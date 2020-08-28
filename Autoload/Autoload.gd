extends Node


var _file
var db_path = "res://Autoload/database.json"

var json_data
var default_data = {
	"game_settings":{
		"fps":{
			"target_fps": 60
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
	Engine.target_fps = targetFPS
