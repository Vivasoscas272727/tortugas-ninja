extends Node2D

# 1. Moldes de los objetos
var molde_pizza = preload("res://pizza.tscn")
var molde_bomba = preload("res://bomba.tscn")
var molde_patilla = preload("res://patilla.tscn")

# 2. Variables del juego
var puntos = 0
var vidas = 5

func _ready() -> void:
	# Nos aseguramos de que la pantalla final empiece invisible
	$PantallaFinal.hide()

func _on_timeout() -> void:
	var posicion_x_azar = randf_range(50, 750)
	var dado = randi_range(1, 10)
	var nuevo_objeto = null
	
	# Ajustamos las probabilidades para los 3 objetos actuales
	if dado <= 4:
		# Del 1 al 4: Sale pizza (40% de probabilidad)
		nuevo_objeto = molde_pizza.instantiate()
	elif dado <= 7:
		# Del 5 al 7: Sale patilla (30% de probabilidad)
		nuevo_objeto = molde_patilla.instantiate()
	else:
		# Del 8 al 10: Sale bomba (30% de probabilidad)
		nuevo_objeto = molde_bomba.instantiate()
		
	# Seguro contra errores: Solo lo movemos y lo creamos si no es null
	if nuevo_objeto != null:
		nuevo_objeto.position = Vector2(posicion_x_azar, 650)
		add_child(nuevo_objeto)

func sumar_punto() -> void:
	puntos += 10
	$HUD/Textopuntos.text = "Puntos: " + str(puntos)

func restar_vida() -> void:
	vidas -= 1
	$HUD/Textovidas.text = "Vidas: " + str(vidas)
	
	# Condición de Game Over
	if vidas <= 0:
		$Timer.stop() # Detiene la caída de objetos
		$PantallaFinal/Label2.text = "Puntaje Final: " + str(puntos)
		$PantallaFinal.show() # Muestra la pantalla de perder

func _on_btnreiniciar_pressed() -> void:
	# Recarga el nivel actual
	get_tree().reload_current_scene()

func _on_btnpersonaje_pressed() -> void:
	# Regresa al menú principal
	get_tree().change_scene_to_file("res://menu_principal.tscn")
