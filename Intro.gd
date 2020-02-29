extends Node2D

var basura: Timer

func _ready():
	basura = Timer.new()
	basura.wait_time = 1.5
	basura.connect("timeout", self, "tirar_basura")
	add_child(basura)
	
	yield(get_tree().create_timer(5), "timeout")
	var proyectil1 = $Node2D/RigidBody2D.duplicate()
	$Node2D.call_deferred("add_child", proyectil1)
	proyectil1.position = Vector2(1500, -20)
	proyectil1.linear_velocity = Vector2.ZERO
	proyectil1.apply_central_impulse(Vector2(-500, -200))
	
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("fall")
	
	yield(get_tree().create_timer(2), "timeout")
	var proyectil2 = $Node2D/RigidBody2D2.duplicate()
	$Node2D.call_deferred("add_child", proyectil2)
	proyectil2.position = Vector2(1600, -20)
	proyectil2.linear_velocity = Vector2.ZERO
	proyectil2.apply_central_impulse(Vector2(-200, -200))

	yield(get_tree().create_timer(1), "timeout")
	var proyectil3 = $Node2D/RigidBody2D3.duplicate()
	$Node2D.call_deferred("add_child", proyectil3)
	proyectil3.position = Vector2(1600, -20)
	proyectil3.linear_velocity = Vector2.ZERO
	proyectil3.apply_central_impulse(Vector2(-500, -200))
	basura.start()
	
	yield(get_tree().create_timer(12), "timeout")
	global.iniciar_tiempo()
	get_tree().call_deferred("change_scene", "res://IntroNivel.tscn")


func _input(event):
	if event.is_action_pressed("ui_select") or \
		event.is_action_pressed("ui_accept"):
		get_tree().call_deferred("change_scene", "res://IntroNivel.tscn")
	
	
func tirar_basura():
	var proyectil1 = $Node2D/RigidBody2D3.duplicate()
	$Node2D.call_deferred("add_child", proyectil1)
	proyectil1.position = Vector2(1500, -20)
	proyectil1.linear_velocity = Vector2.ZERO
	proyectil1.apply_central_impulse(Vector2(-500 * randf() - 100, -200))


func _on_Proyectil_hit(body):
	var piernas = $Piernas.duplicate()
	var torso = $Torso.duplicate()
	var cabeza = $Cabeza.duplicate()
	piernas.position = $AnimatedSprite.position + Vector2(0, 105)
	torso.position = $AnimatedSprite.position
	cabeza.position = $AnimatedSprite.position
	piernas.rotation = 0
	torso.rotation = 0
	cabeza.rotation = 0
	piernas.visible = true
	torso.visible = true
	cabeza.visible = true
	add_child(piernas)
	add_child(torso)
	add_child(cabeza)
	$AnimatedSprite.visible = false
	$AnimatedSprite.call_deferred("queue_free")
	cabeza.add_child($Camera2D)
	$Sonidos/Golpe.play()
