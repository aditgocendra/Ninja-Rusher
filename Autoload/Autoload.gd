extends Node

signal update_score
signal health_pick
signal mana_pick
signal score_arcade

var _file
var db_path = "res://Autoload/database.json"

#android path -----------------------
#var db_path = "user://Autoload/database.json"
#end android path -----------------------


#arcade mode--------------------
var level_arcade : int = 1 setget set_level_arcade
#-------------------------------


# path loading scene------------
var path_load
#-------------------------------


# level succsess------------------
var index_level : int
#---------------------------------


var json_data
# android set default data-----------------------------
var default_data = {
  "adventure_mode": {
	"Level1": {
	  "level_open": true,
	  "limit_camera": {
		"bottom": 1200,
		"left": 0,
		"right": 3650
	  },
	  "path": "res://src/Adventure/Level1.tscn"
	},
	"Level2": {
	  "level_open": false,
	  "limit_camera": {
		"bottom": 1100,
		"left": 0,
		"right": 3845
	  },
	  "path": "res://src/Adventure/Level2.tscn"
	},
	"Level3": {
	  "level_open": false,
	  "limit_camera": {
		"bottom": 1100,
		"left": 0,
		"right": 4500
	  },
	  "path": "res://src/Adventure/Level3.tscn"
	}
  },
  "arcade_mode": {
	"highest_score": {
	  "easy": 0,
	  "hard": 0,
	  "medium": 0
	},
	"level": {
	  "easy": {
		"enemy_damage": 25,
		"hurt_damage": 100
	  },
	  "hard": {
		"enemy_damage": 75,
		"hurt_damage": 25
	  },
	  "medium": {
		"enemy_damage": 50,
		"hurt_damage": 50
	  }
	}
  },
  "data_player": {
	"coin": 0
  },
  "game_settings": {
	"control": {
	  "basic_attack": {
		"modulate": {
		  "a": 1,
		  "b": 1,
		  "g": 1,
		  "r": 1
		},
		"position": {
		  "x": 700.455017,
		  "y": 335.531006
		},
		"scale": {
		  "x": 1,
		  "y": 1
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
		  "x": 548.270996,
		  "y": 392.85199
		},
		"scale": {
		  "x": 1,
		  "y": 1
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
		  "x": 685.534973,
		  "y": 274.821014
		},
		"scale": {
		  "x": 1,
		  "y": 1
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
		  "x": 764.051025,
		  "y": 249.548996
		},
		"scale": {
		  "x": 1,
		  "y": 1
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
		  "x": 33.217999,
		  "y": 373.033997
		},
		"scale": {
		  "x": 1,
		  "y": 1
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
		  "x": 801.473999,
		  "y": 5.776
		},
		"scale": {
		  "x": 1,
		  "y": 1
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
		  "x": 107.799004,
		  "y": 373.109985
		},
		"scale": {
		  "x": 1,
		  "y": 1
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
		  "x": 624.638977,
		  "y": 391.960999
		},
		"scale": {
		  "x": 1,
		  "y": 1
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
		  "x": 620.736023,
		  "y": 318.945007
		},
		"scale": {
		  "x": 1,
		  "y": 1
		}
	  }
	},
	"fps": {
	  "show_fps": true,
	  "target_fps": 60
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
	
	

	
	
	
	
	
