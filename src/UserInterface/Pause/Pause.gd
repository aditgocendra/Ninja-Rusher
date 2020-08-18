extends Control


func _on_Resume_pressed():
	get_tree().paused = false
	self.hide()


func _on_Menu_pressed():
# warning-ignore:return_value_discarded
	get_tree().paused = false
	get_tree().change_scene("res://src/UserInterface/FirstMenu/FirstMenu.tscn")


func _on_Quit_pressed():
	get_tree().quit()
