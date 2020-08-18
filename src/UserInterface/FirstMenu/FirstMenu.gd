extends Control




func _on_Play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/Map/MapTemplate.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Share_pressed():
	pass
