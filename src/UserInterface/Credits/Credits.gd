extends Control



func _on_GDS_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
# warning-ignore:return_value_discarded
			OS.shell_open("https://www.gamedeveloperstudio.com/")


func _on_CraftPix_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
# warning-ignore:return_value_discarded
			OS.shell_open("https://craftpix.net/")


func _on_Free2DGame_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
# warning-ignore:return_value_discarded
			OS.shell_open("https://www.gameart2d.com/")
