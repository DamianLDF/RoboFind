extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocidad = 2000
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
	direccion = angulo.normalized()
	usar_process = true

var movimientoViejo = Vector2(0, 0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if usar_process:
		var colision = self.move_and_collide(direccion * velocidad * delta)
		# Chequeo si existe una colision de algun tipo
		if colision:
			self.queue_free()
		
		movimientoViejo = self.position
		
		
		
		