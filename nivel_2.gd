extends Node2D
var katana = preload("res://katana.png")
var sais = preload("res://sais.png")
var bo = preload("res://bo.png")
var nunchakus = preload("res://nunchakus.png")
	
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
	aplicar_cursor_segun_arma(Global.arma_seleccionada)
	
func aplicar_cursor_segun_arma(arma_seleccionada: String):
	var textura_cursor: Texture
	
	match arma_seleccionada:
		"katana": 
			textura_cursor = katana
		"sais": 
			textura_cursor = sais
		"bo": 
			textura_cursor = bo
		"nunchakus": 
			textura_cursor = nunchakus
	if textura_cursor:
		Input.set_custom_mouse_cursor(textura_cursor, Input.CURSOR_ARROW, Vector2(0, 0))

func _on_timeout() -> void:
	# 1. Hacemos que nazcan desde la parte de ABAJO de la pantalla (Y: 700)
	var posicion_x_azar = randf_range(50, 1100) 
	var dado = randi_range(1, 10)
	var nuevo_objeto = null
	
	# 2. Elegimos qué objeto sale
	if dado <= 4:
		nuevo_objeto = molde_pizza.instantiate()
	elif dado <= 7:
		nuevo_objeto = molde_patilla.instantiate()
	else:
		nuevo_objeto = molde_bomba.instantiate()
		
	# 3. Lo posicionamos abajo, fuera de la vista
	nuevo_objeto.global_position = Vector2(posicion_x_azar, 700)
	get_tree().current_scene.add_child(nuevo_objeto)
	
	# 4. FÍSICAS DE TIRO CRUZADO
	# Empujón hacia arriba muy fuerte (en Godot, Y negativo es hacia arriba)
	var empuje_arriba = randf_range(-700, -900) 
	
	# Empujón lateral: Si nace a la izquierda, lo empujamos a la derecha, y viceversa
	var empuje_lateral = 0
	if posicion_x_azar < 576: # 576 es la mitad exacta de una pantalla de 1152
		empuje_lateral = randf_range(150, 400) # Empuja a la derecha
	else:
		empuje_lateral = randf_range(-400, -150) # Empuja a la izquierda
		
	# ¡Le aplicamos la fuerza combinada para crear la parábola!
	nuevo_objeto.apply_impulse(Vector2(empuje_lateral, empuje_arriba))

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
