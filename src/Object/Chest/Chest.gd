extends RigidBody2D
class_name Chest



func _on_Timer_timeout():
	$AnimationPlayer.play("free")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "free":
		Autoload.coin_score += 10
		self.queue_free()
	

func chest_free():
	$Particles2D.emitting = true
	$Timer.start()

