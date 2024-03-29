extends KinematicBody2D
class_name ReaperMan


var velocity = Vector2.ZERO
var gravity = 1000.0
var FLOOR_NORMAL = Vector2.UP

var speed = 250
var speed_up = false

var health = 200
var damage_player = 40


var _state = State.WALK 
enum State {IDLE, ATTACK, WALK, DEAD}


onready var floor_left = $FloorLeftDetect
onready var floor_right = $FloorRightDetect
onready var area_attack = $AreaAttack
onready var col_sword_attack = $SwordAttack/CollisionPolygon2D
onready var update_tween = $UpdateTween

func _ready():
	enemy_walk()
	

func _physics_process(_delta):
	
	if velocity.x != 0 and _state != State.ATTACK:
		if velocity.x > 0:
			$AnimatedSprite.scale.x = 1
			col_sword_attack.scale.x = 1
			$AreaAttack.position = Vector2(97.888, 0)
		else: 
			$AnimatedSprite.scale.x = -1
			col_sword_attack.scale.x = -1
			$AreaAttack.position = Vector2(-97.888, 0)
			

	velocity = set_velocity(velocity)
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y
	
	var animation = set_anim()
	if $AnimatedSprite.animation != animation:
		$AnimatedSprite.play(animation)
	
	if _state == State.ATTACK:
		if $AnimatedSprite.animation == "attack":
			yield($AnimatedSprite, "animation_finished")
			col_sword_attack.disabled = false
	else : col_sword_attack.disabled = true
	
	if _state == State.DEAD:
		yield($AnimatedSprite, "animation_finished")
		queue_free()
		
	
	

func set_velocity(linear_velocity):
	var new_velocity = linear_velocity
	
	new_velocity.y += gravity * get_physics_process_delta_time()
	if not floor_left.is_colliding():
		new_velocity.x = speed
	elif not floor_right.is_colliding():
		new_velocity.x = -speed
	
	if is_on_wall():
		new_velocity.x *= -1
	
	
	return new_velocity

func set_anim():
	var new_anim
	if _state == State.WALK:
		new_anim = "walk"
	elif _state == State.ATTACK:
		new_anim = "attack"
	elif _state == State.DEAD:
		new_anim = "dead"
#	elif _state == State.IDLE:
#		new_anim = "idle"
	
	return new_anim

func enemy_walk():
	if _state != State.DEAD:
		_state = State.WALK
		if area_attack.position.x > 0:
			velocity.x = speed
		else : velocity.x = -speed


func enemy_attack():
	if _state != State.DEAD:
		_state = State.ATTACK
		velocity.x = 0
	

func enemy_dead():
	if health != 0:
		health -= 25
		$HealthBar.value = health
	
	if health == 0:
		_state = State.DEAD
		velocity.x = 0

func _on_AreaAttack_body_entered(body):
	if body.name == "Player":
		if self.global_position.x < body.global_position.x:
			$AnimatedSprite.scale.x = 1
			col_sword_attack.scale.x = 1
		else:
			$AnimatedSprite.scale.x = -1
			col_sword_attack.scale.x = -1
		enemy_attack()


func _on_AreaAttack_body_exited(body):
	if body.name == "Player":
		enemy_walk()


func _on_SwordAttack_body_entered(body):
	if body.name == "Player":
		body._die($AnimatedSprite.scale.x, damage_player)
		enemy_walk()
		
		
func _on_HealthBar_value_changed(_value):
	if $HealthBar.visible == false:
		$HealthBar.visible = true
	update_tween.interpolate_property($HealthBar, "value", $HealthBar.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_OUT, 0.4)
	update_tween.start()
