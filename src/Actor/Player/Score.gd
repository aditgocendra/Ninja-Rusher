extends HBoxContainer

onready var score_label = $ScoreLabel


func _ready():
# warning-ignore:return_value_discarded
	Autoload.connect("update_score", self, "update")
	Autoload.coin_score = get_coin_score()
	score_label.text = " X " + str(Autoload.coin_score) 
	

func update():
	score_label.text = " X " + str(Autoload.coin_score) 


func get_coin_score():
	var data = Autoload.load_data()
	var coin_player = data["data_player"]["coin"]
	return coin_player
