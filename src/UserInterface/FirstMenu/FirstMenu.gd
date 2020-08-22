extends Control


onready var setting_scene = "res://src/UserInterface/Settings/Settings.tscn"

func _on_Play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/Loading/Game.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Share_pressed():
	pass


func _on_Settings_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(setting_scene)
