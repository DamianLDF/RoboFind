extends RigidBody2D
signal murio
signal dispare
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var movimiento = Vector2.LEFT
var flip = 1

var darVueltaTiming = Timer.new()
                                                          
var textura_normal = preload("res://img/enemigo_terrestre2.png")
var textura_ataque = preload("res://img/enemigo_terrestre2ataque.png")
# Called when the node enters the scene tree for the first time.



func _ready():
	darVueltaTiming.connect("timeout", self, "flipCharacter")
	darVueltaTiming.wait_time = 2.5
	
	
	add_child(darVueltaTiming)
	darVueltaTiming.start()
	
	$Node2D/SpriteExplosion.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func flipCharacter():
	if movimiento == Vector2.LEFT:
			movimiento = Vector2.RIGHT
	else:
		movimiento = Vector2.LEFT

	$Node2D.apply_scale(Vector2(-1,1))
	
	flip *= -1

onready var escenaDisparo: PackedScene = load("res://Laser.tscn")



var puedeDisparar = true

func _process(delta):
	if -100 < self.linear_velocity.x  and self.linear_velocity.x < 100 :
		self.apply_central_impulse(movimiento*delta*30000)
	else:
		self.linear_velocity.x = 0
		
		
	for body in  $Node2D/ChequeoDePlayer.get_overlapping_bodies():
		if body.name == "Player" and puedeDisparar:
			var laser = escenaDisparo.instance()
			var posicionDelRobot = Vector2(self.position.x, self.position.y + 180)
			laser.disparar(body.position - posicionDelRobot, posicionDelRobot)
			emit_signal("dispare", laser)
			puedeDisparar = false
			yield(get_tree().create_timer(2), "timeout")
			puedeDisparar = true
			break
		else:
			pass
#			$Node2D/Sprite.set_texture(textura_normal)
		
		
func fueGolpeado():
	$Node2D/SpriteExplosion.show()
	yield(get_tree().create_timer(0.2), "timeout")
	self.queue_free()
	emit_signal("murio")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		fueGolpeado()