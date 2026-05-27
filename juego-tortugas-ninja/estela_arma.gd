extends Line2D

# 1. LAS VARIABLES
var longitud_estela = 10 

var DATOS_ARMAS = {
	"katana": {"color": Color(0, 0.5, 1), "grosor": 8},   # Azul
	"bo": {"color": Color(0.6, 0, 0.8), "grosor": 15},     # Morado
	"nunchaku": {"color": Color(1, 0.6, 0), "grosor": 12}, # Naranja
	"sai": {"color": Color(1, 0.1, 0.1), "grosor": 6}      # Rojo
}

var arma_actual = "katana" 

# >>> ESTO FALTABA: Cargar la escena de los pedazos en memoria <<<
var escena_pedazos = preload("res://objeto_roto.tscn")


# 2. SE EJECUTA AL INICIAR
func _ready() -> void:
	cambiar_arma(arma_actual)

# 3. FUNCIÓN PARA CAMBIAR EL COLOR Y GROSOR
func cambiar_arma(nombre_arma: String) -> void:
	if DATOS_ARMAS.has(nombre_arma):
		arma_actual = nombre_arma
		self.default_color = DATOS_ARMAS[nombre_arma]["color"]
		self.width = DATOS_ARMAS[nombre_arma]["grosor"]
		print("Arma cambiada a: ", nombre_arma)

# 4. SE EJECUTA TODO EL TIEMPO
func _process(_delta: float) -> void:
	var pos_raton = get_global_mouse_position()
	
	add_point(pos_raton)
	
	if points.size() > longitud_estela:
		remove_point(0)
		
	# Hace que el círculo de colisión siga a la punta de la línea
	$Area2D.global_position = pos_raton


# >>> ESTO FALTABA: La nueva lógica de explosión <<<
func _on_area_2d_body_entered(body: Node2D) -> void:
	# 1. Comprobamos que el objeto tocado sea el original y no un pedazo suelto
	if body.is_in_group("enemigo"):
		var pedazos = escena_pedazos.instantiate()
		pedazos.global_position = body.global_position
		
		# 2. call_deferred le dice a Godot: "Espera a que termine el choque para meter esto"
		get_tree().current_scene.call_deferred("add_child", pedazos)
		
		get_tree().current_scene.sumar_punto()
		# 3. Eliminamos el robot original
		body.queue_free()
	
	elif body.is_in_group("bomba"):
		# Le avisamos al nivel principal que reste una vida
		get_tree().current_scene.restar_vida()
		
		# Opcional: Podrías añadir un efecto de explosión aquí después
		
		# Destruimos la bomba para que no siga cayendo
		body.queue_free()
