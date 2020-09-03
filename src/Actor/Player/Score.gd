extends HBoxContainer

onready var score_label = $ScoreLabel


func _ready():
# warning-ignore:return_value_discarded
	Autoload.connect("update_score", self, "update")


func update():
	score_label.text = " X " + str(Autoload.coin_score) 

