extends Node

signal update_score
signal health_pick
signal mana_pick
signal score_arcade

var _file
var db_path = "res://Autoload/database.json"

#android path -----------------------
#var db_path = "res://users/database.json"
#end android path -----------------------


#arcade mode--------------------
var level_arcade : int = 1 setget set_level_arcade
#-------------------------------


# path loading scene------------
var path_load
#-------------------------------


# level succsess------------------
var index_level
#---------------------------------


var json_data
# android set default data-----------------------------
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
	},
	"arcade_mode":{
		"level":{
		  "easy":{
			"hurt_damage": 100,
			"enemy_damage" : 25
		  },
		  "medium":{
			"hurt_damage": 50,
			"enemy_damage" : 50
		  },
		  "hard":{
			"hurt_damage": 25,
			"enemy_damage" : 75
		  }
		}
  }
	
}


var coin_score : int setget _update_coin
var max_health : int = 100 setget _update_health
var max_mana : int = 100 setget _update_mana
var score_arcade : int setget _update_score_arcade
var game_mode : bool setget setup_game_mode


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


func _update_coin(_score):
	coin_score = _score
	emit_signal("update_score")


func _update_health(_health):
	max_health = _health
	emit_signal("health_pick")


func _update_mana(_mana):
	max_mana = _mana
	emit_signal("mana_pick")


func _update_score_arcade(_score):
	score_arcade = _score
	emit_signal("score_arcade")


func setup_game_mode(new_game_mode):
	# true is adventure
	# false is arcade
	game_mode = new_game_mode


func set_level_arcade(new_arcade_level):
	# 1 is easy
	# 2 is medium
	# 3 is hard
	level_arcade = new_arcade_level
	
	

	
	
	
	
	
