extends Actor
#class_name Player

export var jump_power = 750.0 
const FLOOR_DETECT_DISTANCE = 20.0

var speed = 500.0
var stomp_attack = false
var dashing = false
var glide = false
var stomp_direct = 0

var max_health = 100

onready var spawn_kunai = $AnimatedPlayer/SpawnKunai
onready var col_body = $CollisionShape2D
onready var platform = $PlatformerDetector
onready var col_attack = $AreaAttack/CollAttack
onready var health_bar = $UserInterface/HealthBar/HBoxContainer/HeatlhBG/TextureProgress


func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		$UserInterface/Pause.show()
		
	
	var direction = Vector2.ZERO
	direction = calculate_direction()
	
	
	# is player dead -------------------------------------------------
	var is_dead = false
	if max_health <= 0:
		is_dead = true
	# ----------------------------------------------------------------
	
	
	# dash player-------------------------------------------------------------
	if Input.is_action_pressed("dash") and $AnimatedPlayer.animation != "Idle" and not glide and not is_dead:
		dashing = true
	
	if dashing == false:
		speed = 500 if glide else 800
	else :
		if not is_dead: 
			speed = 1500
	#-------------------------------------------------------------------------
	
	
	if direction.x != 0 and not is_dead:
		$AnimatedPlayer.scale.x = 1 if direction.x > 0 else -1
		col_attack.scale.x = $AnimatedPlayer.scale.x
		
	var is_jump_interrupted = Input.is_action_just_released("jump") and velocity.y < 0.0
	var is_on_platform = platform.is_colliding()
	var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
	
	
	# calculate movement-----------------------------------------------------
	if not is_dead:
		velocity = calculate_velocity(velocity, direction, is_jump_interrupted)
	#------------------------------------------------------------------------
	
	
	#stomp attack enemy-------------------------------------------------------
	if stomp_attack:
		velocity.x = 500 * stomp_direct
	#-------------------------------------------------------------------------
	
	
	#detect stomp enemy---------------------------------------------------------
	var stomp_enemy 
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		var is_stomping = (collider is ReaperMan or collider is Bandit
			and is_on_floor() 
			and collision.normal.dot(Vector2.UP) > 0.5)
		stomp_enemy = is_stomping
	#---------------------------------------------------------------------------
	
	
	# excecute movement player-----------------------------------------------
	if stomp_enemy:
		velocity.y = -500
		velocity = move_and_slide(velocity, FLOOR_NORMAL, true)
	else :
		velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, 
		is_on_platform, 4, 0.9, false)
	# -----------------------------------------------------------------------
	
	
	#Show game over scene-------------
	showGameOver(is_dead)
	#---------------------------------


	# collison attack disable true or false------------
	if $AttackTimer.is_stopped() == false:
		col_attack.disabled = false
	else: col_attack.disabled = true
	#--------------------------------------------------


	# basic attack player-----------------------------------------
	var is_attack = false
	if Input.is_action_just_pressed("attack") and not glide and not is_dead:
		is_attack = true
		
	#----------------------------------------------------------------
	
	
	#slide player-------------------------------------------------- 
	var slide = false
	if Input.is_action_pressed("slide") and not is_dead and $AnimatedPlayer.animation != "Idle" and $AnimatedPlayer.animation != "Attack" and $AnimatedPlayer.animation != "Throw" and $AnimatedPlayer.animation != "JumpThrow" and $AnimatedPlayer.animation != "Jump" and not glide:
		if direction.x != 0.0:
			slide = true
	#---------------------------------------------------------------
	

	# throw player--------------------------------------------------
	var throw = false
	if Input.is_action_just_pressed("throw") and not is_dead and slide == false and not glide:
		throw = spawn_kunai.throw($AnimatedPlayer.scale.x)
	#---------------------------------------------------------------
	
	
	#glide player---------------------------------------------------
	if Input.is_action_just_pressed("glide") and not is_dead and not is_on_floor():
		glide = false if glide else true
	
	if glide and is_on_floor():
		glide = false
	#----------------------------------------------------------------
	
	
	#Scale body glide or not-----------------------------------------
#	col_body.scale = Vector2(1, 0.6) if slide else Vector2(1,1)
	if slide:
		$AnimatedPlayer.position = Vector2(0, 68.751)
	else : $AnimatedPlayer.position = Vector2(0, 0)
	#----------------------------------------------------------------
	
	
	#Animated Player setter--------------------------------------------
	var animation = setAnimation(is_attack, throw, slide, is_dead)
	
	if $AnimatedPlayer.animation != animation and $AttackTimer.is_stopped():
		if is_attack or throw:
			$AttackTimer.start()
		$AnimatedPlayer.play(animation)
	#------------------------------------------------------------------


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
		
	return new_velocity


# set animation player
func setAnimation(is_attack, throw, slide, is_dead):
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
		
	if is_dead:
		new_animation = "Dead"
	
	return new_animation


#calculate die player
func _die(_direction_stomp, damage):
	stomp_direct = _direction_stomp
	if $StompTimer.is_stopped():
		velocity.y -= 500
		stomp_attack = true
		$StompTimer.start()
		velocity = move_and_slide(velocity)
	
	max_health -= damage
	self.health_bar.value = max_health
		


#Show Game Over Scene
func showGameOver(is_dead):
	if is_dead == true and $AnimatedPlayer.animation == "Dead" and velocity.y > 0:
		yield($AnimatedPlayer,"animation_finished")
		$UserInterface/GameOver.show()
		get_tree().paused = true


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
	if body is Bandit or body is ReaperMan:
		body.enemy_dead()


func _on_StompTimer_timeout():
	stomp_attack = false