extends RigidBody2D
signal dispare
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ChequeoDeBorde = get_node("Node2D/ChequeoDeBorde")
onready var ChequeoDePared = get_node("Node2D/ChequeoDePared")

onready var escenaProyector: PackedScene = load("res://Proyectil.tscn")

var movimiento = Vector2.LEFT
var flip = 1
var fuerza = 8000
var atacarTiming = Timer.new()
# Called when the node enters the scene tree for the first time.
func lanzarProyectil():
	for body in  $Node2D/AreaDeAtaque.get_overlapping_bodies():
		if body.name == "Player":
			var proyectil = escenaProyector.instance()
			yield(get_tree().create_timer(1), "timeout")
			var posicionDelRobot = Vector2(self.position.x, self.position.y - 400)
			yield(get_tree().create_timer(1), "timeout")
			proyectil.lanzar(body.position - posicionDelRobot, posicionDelRobot)
			emit_signal("dispare", proyectil)


func _ready():
	atacarTiming.connect("timeout", self, "lanzarProyectil")
	atacarTiming.wait_time = 2.5
	
	
	add_child(atacarTiming)
	atacarTiming.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not ChequeoDeBorde.is_colliding() or ChequeoDePared.is_colliding():
		if movimiento == Vector2.LEFT:
			movimiento = Vector2.RIGHT
		else:
			movimiento = Vector2.LEFT
	
		$Node2D.apply_scale(Vector2(-1,1))
		
		flip *= -1

	if -300 < self.linear_velocity.x  and self.linear_velocity.x < 300 :
		self.apply_central_impulse(movimiento*delta*fuerza)
		
#	for body in  $Node2D/ChequeoDePlayer.get_overlapping_bodies():
#		if body.name == "Player":
#			self.apply_central_impulse(movimiento*delta*3000)
#			break
