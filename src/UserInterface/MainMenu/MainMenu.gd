extends Control


onready var setting_scene = "res://src/UserInterface/Settings/Settings.tscn"
onready var ads_mobile = $AdsenseMobile


func _on_Adventure_pressed():
	# warning-ignore:return_value_discarded
	Autoload.game_mode = true
	Autoload.path_load = "res://src/UserInterface/LevelMenu/LevelMenu.tscn"
	get_tree().change_scene("res://src/UserInterface/Loading/Loading.tscn")

func _on_Quit_pressed():
	get_tree().quit()


func _on_Share_pressed():
	pass


func _on_Settings_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(setting_scene)



func _on_Credit_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/Credits/Credits.tscn")


func _on_Admob_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			ads_mobile.show_interesial()


func _on_Arcade_pressed():
# warning-ignore:return_value_discarded
	Autoload.game_mode = false
	Autoload.path_load = "res://src/UserInterface/ArcadeLevel/ArcadeLevel.tscn"
	get_tree().change_scene("res://src/UserInterface/Loading/Loading.tscn")



