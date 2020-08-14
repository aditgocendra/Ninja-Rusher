extends Actor
class_name Player

export var jump_power = 750.0 
const FLOOR_DETECT_DISTANCE = 20.0

var speed = 500.0
var stomp_attack = false
var dashing = false
var glide = false
var stomp_direct = 0

onready var spawn_kunai = $AnimatedPlayer/SpawnKunai
onready var col_body = $CollisionShape2D
onready var platform = $PlatformerDetector
onready var col_attack = $AreaAttack/CollAttack

func _physics_process(_delta):
	var direction = Vector2.ZERO
	direction = calculate_direction()
	
	
	# dash player-------------------------------------------------------------
	if Input.is_action_pressed("dash") and $AnimatedPlayer.animation != "Idle" and not glide:
		dashing = true
	
	if dashing == false:
		speed = 500 if glide else 800
	else : speed = 1500
	#-------------------------------------------------------------------------
	
	if direction.x != 0:
		$AnimatedPlayer.scale.x = 1 if direction.x > 0 else -1
		col_attack.scale.x = $AnimatedPlayer.scale.x
		
	var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y < 0.0
	var is_on_platform = platform.is_colliding()
	var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
	
	velocity = calculate_velocity(velocity, direction, is_jump_interrupted)
	
	if stomp_attack:
		velocity.x = 500 * stomp_direct
	
	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, 
	is_on_platform, 4, 0.9, false)
	
	
	
	if $AttackTimer.is_stopped() == false:
		col_attack.disabled = false
	else: col_attack.disabled = true
	
	
	# basic attack player-----------------------------------------
	var is_attack = false
	if Input.is_action_just_pressed("attack") and not glide:
		is_attack = true
		
	#----------------------------------------------------------------
	
	
	#slide player-------------------------------------------------- 
	var slide = false
	if Input.is_action_pressed("slide") and $AnimatedPlayer.animation != "Idle" and $AnimatedPlayer.animation != "Attack" and $AnimatedPlayer.animation != "Throw" and $AnimatedPlayer.animation != "JumpThrow" and $AnimatedPlayer.animation != "Jump" and not glide:
		if direction.x != 0.0:
			slide = true
	#---------------------------------------------------------------
	

	# throw player--------------------------------------------------
	var throw = false
	if Input.is_action_just_pressed("throw") and slide == false and not glide:
		throw = spawn_kunai.throw($AnimatedPlayer.scale.x)
	#---------------------------------------------------------------
	
	
	#glide player---------------------------------------------------
	if Input.is_action_just_pressed("glide") and not is_on_floor():
		glide = false if glide else true
	
	if glide and is_on_floor():
		glide = false
	#----------------------------------------------------------------
	
	
	col_body.scale = Vector2(1, 0.6) if slide else Vector2(1,1)
	var animation = setAnimation(is_attack, throw, slide)
	
	if $AnimatedPlayer.animation != animation and $AttackTimer.is_stopped():
		if is_attack or throw:
			$AttackTimer.start()
		$AnimatedPlayer.play(animation)


#calculate direction
func calculate_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)
	
	
# calculate movement player
func calculate_velocity(new_velocity : Vector2, direction, is_jump_interrupted) -> Vector2:
	if $AttackTimer.is_stopped() == false :
		new_velocity.x = 0.0
	else:new_velocity.x = direction.x * speed 
	
	if direction.y != 0.0:
		new_velocity.y = jump_power * direction.y
		
	if is_jump_interrupted:
		new_velocity.y *= 0.6
		
	if glide:
		new_velocity.y *= 0.7
		
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		var collider = collision.collider
#		var is_stomping = (collider is Bandit and 
#		is_on_floor() and collision.normal.dot(Vector2.UP) > 0.7)
#
#		if is_stomping:
#			print(true)
#			new_velocity.y -= 1000

	return new_velocity


# set animation player
func setAnimation(is_attack, throw, slide):
	var new_animation = ""
	
	if is_on_floor():
		new_animation = "Run" if abs(velocity.x) > 0.1 else "Idle"
	else:
		if abs(velocity.y) > 0: new_animation = "Jump" 
	
	if is_attack:
		new_animation = "JumpAttack" if velocity.y != 0 else "Attack"
	
	if throw: 
		new_animation = "JumpThrow" if velocity.y != 0 else "Throw"
		
	if slide and is_on_floor():
		new_animation = "Slide"
	
	if glide and not is_on_floor():
		new_animation = "Glide"
	
	return new_animation


#dash loop ghost
func _on_DashTimer_timeout():
	if dashing == true:
		var ghost = preload("res://src/Actor/Player/Ghost.tscn").instance();
		get_parent().add_child(ghost)
		ghost.position = position
		ghost.texture = $AnimatedPlayer.frames.get_frame($AnimatedPlayer.animation, $AnimatedPlayer.frame)
		ghost.scale.x = $AnimatedPlayer.scale.x /5
		ghost.scale.y = $AnimatedPlayer.scale.y /5
		dashing  = false


func _on_AreaAttack_body_entered(body):
	if body is Bandit:
		body.enemy_dead()


func _die(_direction_stomp):
	stomp_direct = _direction_stomp
	if $StompTimer.is_stopped() and stomp_direct != 0:
		velocity.y -= 500
		stomp_attack = true
		$StompTimer.start()
		velocity = move_and_slide(velocity)
		

func _on_StompTimer_timeout():
	stomp_attack = false
