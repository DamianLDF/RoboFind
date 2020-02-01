extends RigidBody2D

var fuerza : float = 10
var fuerza_salto : float = 600
var state_machine

enum Tipo { CABEZA, TORSO, COMPLETO }

var tipo: int = Tipo.CABEZA

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
		if tipo == Tipo.TORSO or tipo == Tipo.COMPLETO:
			if $GroundTouch.is_colliding():
	#		if state.get_contact_count() > 0:
				apply_central_impulse(Vector2.UP * fuerza_salto)
		
	if Input.is_action_just_pressed("test_cabeza"):
		state_machine.travel("cabeza")
		tipo = Tipo.CABEZA
	if Input.is_action_just_pressed("test_brazos"):
		dar_torso()
	if Input.is_action_just_pressed("test_cuerpo"):
		tipo = Tipo.COMPLETO
		state_machine.travel("completo")
		call_deferred("estabilizar")


func dar_torso():
	tipo = Tipo.TORSO
	fuerza_salto = 250
	state_machine.travel("torso")
	call_deferred("estabilizar")


func estabilizar()->void:
	self.rotation = 0
	self.angular_velocity = 0
