extends Control

#button level instance-----------------------------
onready var open_level = preload("res://src/UserInterface/LevelMenu/LevelOpen.tscn").instance()
onready var close_level = preload("res://src/UserInterface/LevelMenu/LevelClose.tscn").instance()
#--------------------------------------------------

onready var list_level = $ScrollContainer/ListLevel

var count_level

func _ready():
	count_level = get_data_level().size()
	add_button_level()
	
	
func add_button_level():
	var scene_level = get_data_level().values()
	var duplicate_btn
	for i in range(count_level):
		if scene_level[i].level_open:
			duplicate_btn = open_level.duplicate()
			duplicate_btn.path_level = scene_level[i].path
			Autoload.index_level = i
			duplicate_btn.get_node("Label").text = "Level " + str(i + 1)
	
			list_level.add_child(duplicate_btn)
		
	
func get_data_level():
	var data = Autoload.load_data()
	var data_level = data["adventure_mode"]
	return data_level


func _on_BackButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
