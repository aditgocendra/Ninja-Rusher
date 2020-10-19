extends Control


onready var data = Autoload.load_data()

onready var admob = $AdMob
func _ready():
	admob.load_rewarded_video()
	

func _on_RetryBtn_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func _on_NextLevelBtn_pressed():
	get_tree().paused = false
	save_coin_player()
	change_new_open_level()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/Loading/Loading.tscn")


func save_coin_player():
	data["data_player"]["coin"] = Autoload.coin_score
	Autoload.save_data(data)

func change_new_open_level():
	
	Autoload.index_level += 1
	var index = Autoload.index_level
	var string_level = "Level" + str(index + 1)
	
	if data["adventure_mode"].has(string_level):
		data["adventure_mode"][string_level]["level_open"] = true
		Autoload.path_load = data["adventure_mode"][string_level]["path"] 
		Autoload.save_data(data)
	else : Autoload.path_load = "res://src/UserInterface/EndGame/EndGame.tscn"
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "start":
		pass


func _on_MainMenu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
