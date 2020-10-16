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
	Autoload.path_load = next_scene
	get_tree().change_scene("res://src/UserInterface/Loading/Loading.tscn")


func _on_BackButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")


func _on_HighScore_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/HighestScore/ArcadeScore.tscn")
