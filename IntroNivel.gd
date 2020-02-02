extends Control

func _ready():
	match global.nivel:
		1:
			$Nivel1.visible = true
		2:
			$Nivel2.visible = true
		3:
			$Nivel3.visible = true
		4:
			$Ganaste.visible = true
			
	yield(get_tree().create_timer(2),"timeout")

	match global.nivel:
		1:
			get_tree().call_deferred("change_scene", "res://Nivel1.tscn")
		2:
			get_tree().call_deferred("change_scene", "res://Nivel2.tscn")
		3:
			get_tree().call_deferred("change_scene", "res://Nivel3.tscn")
		4:
			global.nivel = 1
			get_tree().call_deferred("change_scene", "res://IntroNivel.tscn")
