extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var usar_process = false

func lanzar(direccion, ubicacion):
	self.position = ubicacion
	self.apply_central_impulse(direccion.normalized()*800)
#	usar_process = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):
#	if usar_process:
#		# Chequeo si existe una colision de algun tipo
#		for body in $AreaDeAtaque.get_overlapping_bodies():
##				print("Nombre del Objeto que colisiono: ", body.name)
#			if body.name == "Player":
#				body.fueGolpeado()
#
##		if self.linear_velocity.length() < 30:
##			call_deferred("queue_free")
#
#
#
func fueGolpeado():
	print ("proyectil golpeado")
	pass
	
func _on_AreaDeAtaque_body_entered(body):
	body.fueGolpeado()
	$AreaDeAtaque.call_deferred("queue_free")


func _on_ChoqueSuelo_area_entered(area):
	if has_node("AreaDeAtaque"):
		$AreaDeAtaque.call_deferred("queue_free")
