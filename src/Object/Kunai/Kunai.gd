extends RigidBody2D
class_name Kunai



func _on_FreeTime_timeout():
	queue_free()


func _on_Kunai_body_entered(body):
	if body is Bandit:
#		var direct_sprite = -1 if self.linear_velocity.x > 0 else 1
		body.enemy_dead()
		queue_free()
