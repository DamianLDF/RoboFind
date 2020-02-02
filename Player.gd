extends RigidBody2D
signal zoom_changed
signal lose
signal cambia_vida

var fuerza : float = 20
var fuerza_salto_max : float = 1100
var fuerza_salto : float = fuerza_salto_max
var state_machine


enum Tipo { CABEZA, TORSO, COMPLETO }

var tipo: int = Tipo.CABEZA

var danado : bool = false
var invulnerable : bool = false


func _ready() -> void:
	state_machine = $AnimationTree.get("parameters/playback")
	
func _integrate_forces(state):
	if not danado:
		var prox_anim : String = ""
		if Input.is_action_pressed("game_right"):
			if puede_acelerar():
				apply_central_impulse(Vector2.RIGHT * fuerza)
			if $GroundTouch.is_colliding():
				if tipo == Tipo.TORSO:
					prox_anim = "crawl"
				elif tipo == Tipo.COMPLETO:
					prox_anim = "camina"
			call_deferred("face_direction", 1)
		elif Input.is_action_pressed("game_left"):
			if puede_acelerar():
				apply_central_impulse(Vector2.LEFT * fuerza)
			if $GroundTouch.is_colliding():
				if tipo == Tipo.TORSO:
					prox_anim = "crawl"
				elif tipo == Tipo.COMPLETO:
					prox_anim = "camina"
			call_deferred("face_direction", -1)
		else:
			match tipo:
				Tipo.CABEZA:
					prox_anim = "cabeza"
				Tipo.TORSO:
					prox_anim = "torso"
				Tipo.COMPLETO:
					prox_anim = "completo"
		if Input.is_action_just_pressed("game_jump"):
			if tipo == Tipo.TORSO or tipo == Tipo.COMPLETO:
				if $GroundTouch.is_colliding():
		#		if state.get_contact_count() > 0:
					if tipo == Tipo.TORSO:
						apply_central_impulse(Vector2.UP * fuerza_salto)
					elif tipo == Tipo.COMPLETO:
						apply_central_impulse(Vector2.UP * fuerza_salto)
					
		if Input.is_action_pressed("game_attack"):
			if tipo == Tipo.TORSO:
				prox_anim = "golpe"
				for body in $Flippables/AtaqueTorso.get_overlapping_bodies():
					if body.name.begins_with("Enemigo"):
						body.fueGolpeado()
			if tipo == Tipo.COMPLETO:
				prox_anim = "patada"
				for body in $Flippables/Patada.get_overlapping_bodies():
					if body.name.begins_with("Enemigo"):
						body.fueGolpeado()
					
			elif tipo == Tipo.COMPLETO:
				pass
		
		if prox_anim != "golpe" and prox_anim != "patada":
			if not $GroundTouch.is_colliding():
				if tipo == Tipo.TORSO:
					prox_anim = "torsosalto"
				elif tipo == Tipo.COMPLETO:
					if linear_velocity.y < 0:
						prox_anim = "salto"
					else:
						prox_anim = "caida"
			elif abs(linear_velocity.x) < 3:
				if tipo == Tipo.TORSO:
					prox_anim = "torso"
				elif tipo == Tipo.COMPLETO:
					prox_anim = "completo"
					
		if prox_anim != "":
			state_machine.travel(prox_anim)
		
		if Input.is_action_just_pressed("test_cabeza"):
			state_machine.travel("cabeza")
			tipo = Tipo.CABEZA
		if Input.is_action_just_pressed("test_brazos"):
			dar_torso()
		if Input.is_action_just_pressed("test_cuerpo"):
			dar_cuerpo()


func face_direction(direction : int):
	if tipo != Tipo.CABEZA:
		if linear_velocity.x * direction > 0:
			$Flippables.scale.x = direction


func puede_acelerar()->bool:
	if $GroundTouch.is_colliding():
		if tipo == Tipo.TORSO:
			if abs(linear_velocity.x) < 300:
				return true
		elif tipo == Tipo.COMPLETO:
			if abs(linear_velocity.x) < 1000:
				return true
		else:
			if abs(linear_velocity.x) < 4000:
				return true
	else: 
		if tipo == Tipo.TORSO:
			if abs(linear_velocity.x) < 300:
				return true
		elif tipo == Tipo.COMPLETO:
			if abs(linear_velocity.x) < 600:
				return true
		else:
			if abs(linear_velocity.x) < 800:
				return true
	return false


func ajustar_zoom():
	if tipo == Tipo.TORSO:
		print ("zoom torso")
		$Camera2D.zoom = Vector2(2,2)
		print (str($Camera2D.zoom))
	elif tipo == Tipo.COMPLETO:
		print ("zoom completo")
		$Camera2D.zoom = Vector2(2,2)
	else:
		print ("zoom cabeza")
		$Camera2D.zoom = Vector2(1,1)
	
func dar_torso():
	tipo = Tipo.TORSO
	fuerza_salto = fuerza_salto_max / 3
	state_machine.travel("torso")
	global.cambiar_vida(6)
	emit_signal("cambia_vida")
	call_deferred("estabilizar")
	
	
func dar_cuerpo():
	tipo = Tipo.COMPLETO
	fuerza_salto = fuerza_salto_max / 5 * 3
	state_machine.travel("completo")
	global.cambiar_vida(10)
	emit_signal("cambia_vida")
	emit_signal("zoom_changed", Vector2(2, 2))
	call_deferred("estabilizar")


func estabilizar()->void:
	self.rotation = 0
	self.angular_velocity = 0


func fueGolpeado():
	if not invulnerable:
		invulnerable = true
		danado = true
#		$Sonidos/Dano.play()
		global.restar_vida()
		emit_signal("cambia_vida")
		if tipo == Tipo.TORSO:
			state_machine.travel("torsodano")
		elif tipo == Tipo.COMPLETO:
			state_machine.travel("dano")
		
		if global.vida == 0:
			yield(get_tree().create_timer(2),"timeout")
			get_tree().call_deferred("change_scene", "res://IntroNivel.tscn")
		else:
			yield(get_tree().create_timer(.5),"timeout")
		
		if tipo == Tipo.TORSO:
			state_machine.travel("torso")
		elif tipo == Tipo.COMPLETO:
			state_machine.travel("completo")
		danado = false
		yield(get_tree().create_timer(1),"timeout")
		invulnerable = false
