extends Control



func _on_PlayAgain_pressed():
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func _on_Quit_pressed():
	get_tree().quit()


func _on_Menu_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/FirstMenu/FirstMenu.tscn")
