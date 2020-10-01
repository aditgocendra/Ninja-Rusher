extends Label

func _ready():
# warning-ignore:return_value_discarded
	Autoload.connect("score_arcade", self, "update_new_score")



func update_new_score():
	$AnimationPlayer.play("update_score")
	self.text = "Score : " + str(Autoload.score_arcade)
