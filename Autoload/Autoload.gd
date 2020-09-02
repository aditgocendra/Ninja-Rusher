extends Node


var _file
var db_path = "res://Autoload/database.json"

var json_data
var default_data = {
	"game_settings":{
		"fps":{
			"show_fps": true,
			"target_fps": 60
		},
		"control":{
		"basic_attack": {
			"modulate": {
			  "a": 1,
			  "b": 1,
			  "g": 1,
			  "r": 1
			},
			"position": {
			  "x": 700.455,
			  "y": 335.531
			},
			"scale":{
			  "x":1,
			  "y":1
			}
	  },
	  "throw": {
			"modulate": {
			  "a": 1,
			  "b": 1,
			  "g": 1,
			  "r": 1
			},
			"position": {
			  "x": 620.736,
			  "y": 318.945
			},
			"scale":{
			  "x":1,
			  "y":1
			}
	  },
	  "slide": {
			"modulate": {
			  "a": 1,
			  "b": 1,
			  "g": 1,
			  "r": 1
			},
			"position": {
			  "x": 624.639,
			  "y": 391.961
			},
			"scale":{
			  "x":1,
			  "y":1
			}
	  },
	  "glide": {
			"modulate": {
			  "a": 1,
			  "b": 1,
			  "g": 1,
			  "r": 1
			},
			"position": {
			  "x": 685.535,
			  "y": 274.821
			},
			"scale":{
			  "x":1,
			  "y":1
			}
	  },
	  "dash": {
			"modulate": {
			  "a": 1,
			  "b": 1,
			  "g": 1,
			  "r": 1
			},
			"position": {
			  "x": 548.271,
			  "y": 392.852
			},
			"scale":{
			  "x":1,
			  "y":1
			}
	  },
	  "jump": {
			"modulate": {
			  "a": 1,
			  "b": 1,
			  "g": 1,
			  "r": 1
			},
			"position": {
			  "x": 764.051,
			  "y": 249.549
			},
			"scale":{
			  "x":1,
			  "y":1
			}
	  },
	  "right": {
			"modulate": {
			  "a": 1,
			  "b": 1,
			  "g": 1,
			  "r": 1
			},
			"position": {
			  "x": 107.799,
			  "y": 373.11
			},
			"scale":{
			  "x":1,
			  "y":1
			}
	  },
	  "left": {
			"modulate": {
			  "a": 1,
			  "b": 1,
			  "g": 1,
			  "r": 1
			},
			"position": {
			  "x": 33.218,
			  "y": 373.034
			},
			"scale":{
			  "x":1,
			  "y":1
			}
	  },
		"pause": {
			"modulate": {
			  "a": 1,
			  "b": 1,
			  "g": 1,
			  "r": 1
			},
			"position": {
			  "x": 801.474,
			  "y": 5.776
			},
			"scale": {
			  "x": 1,
			  "y": 1
			}
		  }
	}
	}
}

func _ready():
	var data_game = load_data()
	set_target_fps(data_game)
	
# database local--------------------------------------
func load_data():
	_file = File.new()
		
	if not _file.file_exists(db_path):
		save_data(default_data)
		return default_data
	else:
		_file.open(db_path, File.READ)
		
		json_data = parse_json(_file.get_as_text())
		
		if json_data.size() > 0:
			return json_data


func save_data(new_data):
	_file = File.new()
	
	_file.open(db_path, File.WRITE)
	_file.store_line(to_json(new_data))
	_file.close()
# end database local-----------------------------------


func set_target_fps(data_game):
	var targetFPS = data_game["game_settings"]["fps"]["target_fps"]
	
	if targetFPS > 60:
		OS.vsync_enabled = false 
	else : OS.vsync_enabled = true
	
	Engine.target_fps = targetFPS
