extends RigidBody2D

onready var cabeza : RigidBody2D = $Cabeza
onready var torso : RigidBody2D = $Torso
onready var cuerpo : RigidBody2D = $Completo

var fuerza : float = 10
var fuerza_salto : float = 600
var state_machine

func _ready() -> void:
#	remove_child(torso)
#	remove_child(cuerpo)
	state_machine = $AnimationTree.get("parameters/playback")
	
func _integrate_forces(state):
	if Input.is_action_pressed("game_right"):
		apply_central_impulse(Vector2.RIGHT * fuerza)
	elif Input.is_action_pressed("game_left"):
		apply_central_impulse(Vector2.LEFT * fuerza)
		
	if Input.is_action_just_pressed("game_jump"):
		if $GroundTouch.is_colliding():
#		if state.get_contact_count() > 0:
			apply_central_impulse(Vector2.UP * fuerza_salto)
		
	if Input.is_action_just_pressed("test_cabeza"):
		state_machine.travel("cabeza")
	if Input.is_action_just_pressed("test_brazos"):
		state_machine.travel("torso")
		call_deferred("estabilizar")
	if Input.is_action_just_pressed("test_cuerpo"):
		state_machine.travel("completo")
		call_deferred("estabilizar")

func estabilizar()->void:
	self.rotation = 0
	self.angular_velocity = 0
