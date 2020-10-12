extends Control



func _on_RetryBtn_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_NextLevelBtn_pressed():
	get_tree().paused = false
	save_coin_player()
	get_tree().reload_current_scene()



func save_coin_player():
	var data = Autoload.load_data()
	data["data_player"]["coin"] = Autoload.coin_score
	Autoload.save_data(data)
