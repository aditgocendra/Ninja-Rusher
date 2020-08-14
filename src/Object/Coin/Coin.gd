extends Area2D


func _ready():
	$AnimationPlayer.play("_start")

func _on_Coin_body_entered(body):
	if body is Player:
		$AnimationPlayer.play("get_coin")




func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "get_coin":
		queue_free()
