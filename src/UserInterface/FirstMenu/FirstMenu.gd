extends Control



func _on_Play_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print(true)


func _on_Quit_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			get_tree().quit()
