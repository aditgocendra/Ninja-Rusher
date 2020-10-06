extends KinematicBody2D
class_name Bandit


var velocity = Vector2.ZERO
var gravity = 1500.0
var FLOOR_NORMAL = Vector2.UP

var speed = 350


var health = 100
var enemy_damage
var hurt_damage 

var direct_player_attack = 0

var _state = State.WALK 
enum State {IDLE, ATTACK, WALK, DEAD, HURT}


onready var floor_left = $FloorLeftDetect
onready var floor_right = $FloorRightDetect
onready var area_attack = $AreaAttack
onready var col_sword_attack = $SwordAttack/CollisionPolygon2D
onready var col_area_attack = $AreaAttack/CollisionShape2D


func _ready():
	if Autoload.game_mode == false:
		set_level_arcade()
	else : set_level_adventure()
	enemy_walk()
	print(enemy_damage)


func _physics_process(_delta):
#	print(_state)
	if velocity.x != 0:
		if velocity.x > 0:
			$AnimatedSprite.scale.x = 1
			col_sword_attack.scale.x = 1
			area_attack.position.x = 100
		else: 
			$AnimatedSprite.scale.x = -1
			col_sword_attack.scale.x = -1
			area_attack.position.x = -100
			
	velocity = set_velocity(velocity)
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL, false).y
	
	var animation = set_anim()
	
	if $AnimatedSprite.animation != animation:
		$AnimatedSprite.play(animation)
	
	
	if _state == State.DEAD:
		if $StateChanger.is_stopped():
			$StateChanger.start()
			dead_state()
		
		
	if _state == State.HURT:
		col_area_attack.disabled = true
		yield($AnimatedSprite, "animation_finished")
		col_area_attack.disabled = false
		enemy_walk()
	
		
func set_velocity(linear_velocity):
	var new_velocity = linear_velocity
	
	new_velocity.y += gravity * get_physics_process_delta_time()

	if not floor_left.is_colliding():
		new_velocity.x = speed
	elif not floor_right.is_colliding():
		new_velocity.x = -speed
	
	var body_player = false
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider != null:
			if collision.collider.name == "Player":
				body_player = true
			
	if is_on_wall() and not body_player:
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
	elif _state == State.HURT:
		new_anim = "hurt"
	
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
		enemy_hurt()
		
	if health <= 0:
		_state = State.DEAD
	velocity.x = 0


func enemy_hurt():
	_state = State.HURT
	health -= hurt_damage
	$HealthBar.value = health


func _on_AreaAttack_body_entered(body):
	if body.name == "Player" and _state != State.HURT:
		enemy_attack()


func _on_AreaAttack_body_exited(body):
	if body.name == "Player" and _state != State.HURT:
		enemy_walk()


func _on_SwordAttack_body_entered(body):
	if body.name == "Player":
		body._die($AnimatedSprite.scale.x, enemy_damage)
		enemy_walk()

func _on_HealthBar_value_changed(_value):
	if $HealthBar.visible == false:
		$HealthBar.visible = true
	


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "attack":
		col_sword_attack.disabled = false
	else : col_sword_attack.disabled = true


func dead_state():
	yield($AnimatedSprite, "animation_finished")
	if has_node("PotionSpawner"):
		$PotionSpawner.spawn()
	Autoload.score_arcade += 10
	queue_free()


func set_level_arcade():
	var data = Autoload.load_data()
	var get_data_level = data["arcade_mode"]["level"]
	var level_data
	
	if Autoload.level_arcade == 1:
		level_data = get_data_level["easy"]
	elif Autoload.level_arcade == 2:
		level_data = get_data_level["medium"]
	else : level_data = get_data_level["hard"]
	
	enemy_damage = level_data["enemy_damage"]
	hurt_damage = level_data["hurt_damage"]
	
	
func set_level_adventure():
	enemy_damage = 25
	hurt_damage = 25
	
	
	
	
	
	
	
	
	
