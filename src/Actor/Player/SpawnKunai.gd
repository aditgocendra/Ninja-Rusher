extends Position2D

var speed_kunai = 1200.0
onready var Kunai  = preload("res://src/Object/Kunai/Kunai.tscn")
onready var cooldown = $Cooldown


func throw(direction = 1):
	print(cooldown.is_stopped())
	if not cooldown.is_stopped():
		return false
	else:
		var kunai =  Kunai.instance()
		kunai.scale.x = direction
		kunai.global_position = global_position
		kunai.linear_velocity = Vector2(direction * speed_kunai, 0)
		
		kunai.set_as_toplevel(true)
		add_child(kunai)
		cooldown.start()
		return true
	
	
