extends RigidBody2D

func _ready():
	pass



func _on_Rosca_body_entered(body):
	if body.name == "Player":
		body.dar_cuerpo()
		call_deferred("queue_free")