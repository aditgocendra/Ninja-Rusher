extends RigidBody2D
class_name Kunai



func _on_FreeTime_timeout():
	queue_free()


func _on_Kunai_body_entered(body):
	if body is Bandit:
		body.enemy_dead()
		queue_free()
