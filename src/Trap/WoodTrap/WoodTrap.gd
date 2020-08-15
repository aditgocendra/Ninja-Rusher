extends Area2D



func _ready():
	$AnimationPlayer.play("play_trap")
	




func _on_WoodTrap_body_entered(body):
	if body is Player:
		body._die(0)
