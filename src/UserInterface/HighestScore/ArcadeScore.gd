extends Control

#value high score--------
var highest_score
#------------------------

# load node high score --------------------------
onready var high_score = $VBoxContainer/HighScore
#------------------------------------------------


func _ready():
	var data =  Autoload.load_data()
	# default highest score
	highest_score = data["arcade_mode"]["highest_score"]
	high_score.text = str(highest_score["easy"])
	


func _on_BackButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/ArcadeLevel/ArcadeLevel.tscn")


func _on_Easy_pressed():
	high_score.text = str(highest_score["easy"])

func _on_Medium_pressed():
	high_score.text = str(highest_score["medium"])


func _on_Hard_pressed():
	high_score.text = str(highest_score["hard"])
