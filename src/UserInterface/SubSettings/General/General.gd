extends VBoxContainer

onready var check_fps = $ShowFPS/CheckFPS
onready var fps_check_30 = $FPS30/Check
onready var fps_check_60 = $FPS60/Check
onready var fps_check_120 = $FPS120/Check


func _ready():
	var data = Autoload.json_data
	set_fps_setting(data)
	
	
func set_fps_setting(data_game):
	var fps_show = data_game["game_settings"]["fps"]["show_fps"]
	var target_fps = data_game["game_settings"]["fps"]["target_fps"]
	
	check_fps.pressed = true if fps_show else false
	
	if target_fps == 30:
		fps_check_30.pressed = true
	elif target_fps == 60:
		fps_check_60.pressed = true
	else : fps_check_120.pressed = true




func save_new_fps():
	var data  = Autoload.load_data()
	var new_target = get_target_fps()
	
	var new_sett = {
		"target_fps" : new_target,
		"show_fps" : check_fps.pressed
		
	}
	
	data["game_settings"]["fps"] = new_sett
	
	Autoload.save_data(data)
	Autoload.set_target_fps(data)
	

func get_target_fps():
	var target
	if fps_check_30.pressed:
		target = 30
	elif fps_check_60.pressed:
		target = 60
	else : target = 120
	
	return target
	
	

func _on_SaveFPS_pressed():
	save_new_fps()
	


func _on_Check_30FPS_gui_input(event):
	if event.is_pressed():
		fps_check_60.pressed = false
		fps_check_120.pressed = false

func _on_Check_60FPS_gui_input(event):
	if event.is_pressed():
		fps_check_30.pressed = false
		fps_check_120.pressed = false



func _on_Check_120FPS_gui_input(event):
	if event.is_pressed():
		fps_check_30.pressed = false
		fps_check_60.pressed = false
