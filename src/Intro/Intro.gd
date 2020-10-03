extends Control

onready var new_scene = "res://src/UserInterface/MainMenu/MainMenu.tscn"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "start":
# warning-ignore:return_value_discarded
		get_tree().change_scene(new_scene)
