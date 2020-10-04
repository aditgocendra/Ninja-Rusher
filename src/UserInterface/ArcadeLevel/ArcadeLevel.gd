extends Control

var next_scene = "res://src/Arcade/Arcade.tscn"


func _on_Easy_pressed():
	Autoload.level_arcade = 1
	change_next_scene()


func _on_Medium_pressed():
	Autoload.level_arcade = 2
	change_next_scene()

func _on_Hard_pressed():
	Autoload.level_arcade = 3
	change_next_scene()


func change_next_scene():
	# warning-ignore:return_value_discarded
	get_tree().change_scene(next_scene)
