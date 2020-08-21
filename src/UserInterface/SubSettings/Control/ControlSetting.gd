extends Control

onready var setting_scene = "res://src/UserInterface/Settings/Settings.tscn"


func _on_Exit_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(setting_scene)
