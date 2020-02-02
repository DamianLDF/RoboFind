extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocidad = 1200
# Called when the node enters the scene tree for the first time.
var usar_process = false
func _ready():
	pass
#	self.set_process(false)
#	var angulo = Vector2(-2, 5) 
#	$Sprite.rotate(angulo.angle())
#	$ColisionLaser.rotate(angulo.angle())
#	direccion = angulo.normalized()
	

var direccion

func disparar(angulo: Vector2, positionInicial):
	self.position.x = positionInicial.x
	self.position.y = positionInicial.y
	$Sprite.rotate(angulo.angle())
	$ColisionLaser.rotate(angulo.angle())
	$AreaDeAtaque/ColisionDeAtaque.rotate(angulo.angle())
	direccion = angulo.normalized()
	usar_process = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if usar_process:
		var colision = self.move_and_collide(direccion * velocidad * delta)
		# Chequeo si existe una colision de algun tipo
		if colision:
			for body in  $AreaDeAtaque.get_overlapping_bodies():
#				print("Nombre del Objeto que colisiono: ", body.name)
				if body.name == "Player":
					body.fueGolpeado()
				
			call_deferred("queue_free")
		
		
		
		