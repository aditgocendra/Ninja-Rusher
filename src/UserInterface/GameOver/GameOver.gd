extends Control



func _on_Restart_pressed():
	# game_mode arcade save arcade score
	if Autoload.game_mode == false:
		save_arcade_score()
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func _on_Quit_pressed():
	#quit game
	get_tree().quit()


func _on_Menu_pressed():
	# game_mode arcade save arcade score
	if Autoload.game_mode == false:
		save_arcade_score()
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")





# saving arcade score
func save_arcade_score():
	var data = Autoload.load_data()
	var LevelArcade = Autoload.level_arcade
	
	var old_score
	var new_score  = Autoload.score_arcade
	
	if LevelArcade == 1:
		old_score =  data["arcade_mode"]["highest_score"]["easy"]
	elif LevelArcade == 2:
		old_score = data["arcade_mode"]["highest_score"]["medium"]
	else : old_score =  data["arcade_mode"]["highest_score"]["hard"]
	
	if new_score > old_score:
		Autoload.save_data(data)
		Autoload.score_arcade = 0



