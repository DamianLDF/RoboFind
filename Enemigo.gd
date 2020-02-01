extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var Velocidad
onready var seVaACaer = get_node("RayCast2D")
var movimiento = Vector2.LEFT
var flip = 1
var flipImagen = true
# Called when the node enters the scene tree for the first time.


func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	
	if not seVaACaer.is_colliding():
		if movimiento == Vector2.LEFT:
			movimiento = Vector2.RIGHT
		else:
			movimiento = Vector2.LEFT
	
		get_node("Sprite").set_flip_h(flipImagen)
		flipImagen = !flipImagen
		
		seVaACaer.position = Vector2(seVaACaer.position.x + flip*200, seVaACaer.position.y)
		flip *= -1

	if -200 < self.linear_velocity.x  and self.linear_velocity.x < 200 :
		self.apply_central_impulse(movimiento*delta*2000)


func _on_Area2D_body_entered(body):
	self.queue_free()
