extends RigidBody2D

signal dispare
signal muere
signal cambia_vida
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ChequeoDeBorde = get_node("Node2D/ChequeoDeBorde")
onready var ChequeoDePared = get_node("Node2D/ChequeoDePared")

onready var escenaProyector: PackedScene = load("res://Proyectil.tscn")

var movimiento = Vector2.LEFT
var flip = 1
var fuerza = 60000
var atacarTiming = Timer.new()
var vida_max : int = 10
var vida : int = vida_max
var atacado : bool = false
var muerto : bool = false


# Called when the node enters the scene tree for the first time.
func lanzarProyectil():
	for body in  $Node2D/AreaDeAtaque.get_overlapping_bodies():
		var proyectil = escenaProyector.instance()
		var posicionDelRobot = self.position + Vector2( \
				$Node2D/FuenteProyectiles.position.x * flip,
				$Node2D/FuenteProyectiles.position.y)
		proyectil.lanzar(body.position - posicionDelRobot, posicionDelRobot)
		emit_signal("dispare", proyectil)


func _ready():
	atacarTiming.connect("timeout", self, "lanzarProyectil")
	atacarTiming.wait_time = 1.5
	add_child(atacarTiming)
	atacarTiming.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not muerto:
		if not ChequeoDeBorde.is_colliding() or ChequeoDePared.is_colliding():
			cambiar_direccion()	
		if -300 < self.linear_velocity.x  and self.linear_velocity.x < 300 :
			self.apply_central_impulse(movimiento*delta*fuerza)
			
	#	for body in  $Node2D/ChequeoDePlayer.get_overlapping_bodies():
	#		if body.name == "Player":
	#			self.apply_central_impulse(movimiento*delta*3000)
	#			break

func cambiar_direccion():
	if movimiento == Vector2.LEFT:
		movimiento = Vector2.RIGHT
	else:
		movimiento = Vector2.LEFT

	$Node2D.apply_scale(Vector2(-1,1))
	
	flip *= -1


func fueGolpeado() -> void:
	if not atacado:
		atacado = true
		vida -= 1
		emit_signal("cambia_vida", vida, vida_max)
		if vida <= 0:
			muerto = true
			atacarTiming.stop()
			$Steps.stop()
			$Steps2.stop()
			$Steps3.stop()
			$Explosion.play()
			set_collision_layer_bit(3, false)
			$Node2D/Sprite.play("muere")
#			yield(get_tree().create_timer(5),"timeout")
			emit_signal("muere")
			return
		cambiar_direccion()
		yield(get_tree().create_timer(1),"timeout")
		atacado = false


func aparecer() -> void:
	$Steps.play()
	yield(get_tree().create_timer(.4),"timeout")
	$Steps2.play()
	yield(get_tree().create_timer(.4),"timeout")
	$Steps3.play()

func _on_AreaAgarre_body_entered(body):
	# Agarrar items: hacerlos desaparecer
	body.call_deferred("queue_free")
