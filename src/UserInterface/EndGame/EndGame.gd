extends Control

var level_menu_scene = "res://src/UserInterface/LevelMenu/LevelMenu.tscn"


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
# warning-ignore:return_value_discarded
	get_tree().change_scene(level_menu_scene)
	get_tree().paused = false
