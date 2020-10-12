extends TextureButton


#default path level--------------------------------------
var path_level = "res://src/Adventure/Level1.tscn"
#--------------------------------------------------------


func _on_LevelButton_pressed():
# warning-ignore:return_value_discarded
	Autoload.path_load = path_level
	get_tree().change_scene("res://src/UserInterface/Loading/Loading.tscn")
