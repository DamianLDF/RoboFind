extends RigidBody2D
signal murio
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var Velocidad
onready var ChequeoDeBorde = get_node("Node2D/ChequeoDeBorde")
onready var ChequeoDePared = get_node("Node2D/ChequeoDePared")
onready var ChequeoDePiso = get_node("Node2D/ChequeoDePiso")
onready var Vista = get_node("Vista")
var movimiento = Vector2.LEFT
var flip = 1
var flipImagen = true
                                                          
var textura_normal = "normal"
var textura_ataque = "ataque"
# Called when the node enters the scene tree for the first time.
var exploded:bool = false

func _ready():
	$Node2D/SpriteExplosion.hide()
	yield(get_tree().create_timer(randf()), "timeout")
	$Node2D/Pasos.play()
	yield(get_tree().create_timer(.2), "timeout")
	$Node2D/Pasos2.play()
	yield(get_tree().create_timer(.2), "timeout")
	$Node2D/Pasos3.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if not ChequeoDeBorde.is_colliding() or ChequeoDePared.is_colliding():
		if ChequeoDePiso.is_colliding():
			if movimiento == Vector2.LEFT:
				movimiento = Vector2.RIGHT
			else:
				movimiento = Vector2.LEFT
		
			$Node2D.apply_scale(Vector2(-1,1))
			
			flip *= -1

	if -200 < self.linear_velocity.x  and self.linear_velocity.x < 200 :
		self.apply_central_impulse(movimiento*delta*2000)
		
	for body in  $Node2D/ChequeoDePlayer.get_overlapping_bodies():
		if body.name == "Player":
			self.apply_central_impulse(movimiento*delta*3000)
			$Node2D/Sprite.set_animation(textura_ataque)
			break
		else:
			$Node2D/Sprite.set_animation(textura_normal)
	
	for body in  $Node2D/AreaDeAtaque.get_overlapping_bodies():
		body.fueGolpeado()


func fueGolpeado():
	exploded = true
	set_process(false)
	mass = .1
	$Node2D/SpriteExplosion.show()
	$Node2D/SonidoExplosion.play()
	yield(get_tree().create_timer(0.5), "timeout")
	global.pacifico = false
	call_deferred("queue_free")
	emit_signal("murio")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		fueGolpeado()
