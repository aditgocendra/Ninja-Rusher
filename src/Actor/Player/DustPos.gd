extends Position2D

onready var foot_dust_jump = preload("res://src/Actor/Effect/JumpParticle.tscn")


func effect_dust():
	var dust =  foot_dust_jump.instance()
	dust.global_position = global_position
	dust.set_as_toplevel(true)
	add_child(dust)
