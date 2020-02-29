extends RigidBody2D

func _on_Pickup(body):
	if body.name == "Player":
		body.dar_alas()
		call_deferred("queue_free")
