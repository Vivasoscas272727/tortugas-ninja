extends Line2D

# 1. LAS VARIABLES
var pedazos_pizza = preload("res://objeto_roto.tscn")
var pedazos_patilla = preload("res://patilla_roto.tscn")
var longitud_estela = 10 

var DATOS_ARMAS = {
	"katana": {"color": Color(0, 0.5, 1), "grosor": 8},   # Azul
	"bo": {"color": Color(0.6, 0, 0.8), "grosor": 15},     # Morado
	"nunchaku": {"color": Color(1, 0.6, 0), "grosor": 12}, # Naranja
	"sai": {"color": Color(1, 0.1, 0.1), "grosor": 6}      # Rojo
}

var arma_actual = "katana" 

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

# 5. LÓGICA DE CORTAR Y EXPLOSIONES
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Comprobamos que el objeto tocado sea el original y no un pedazo suelto
	if body.is_in_group("enemigo"):
		var pedazos = null
		
		# Convertimos el nombre a minúsculas para que no haya errores de texto
		var nombre_objeto = body.name.to_lower()
		
		# Revisamos el nombre del objeto para saber qué pedazos instanciar
		if nombre_objeto.begins_with("pizza"):
			pedazos = pedazos_pizza.instantiate()
		elif nombre_objeto.begins_with("patilla"):
			pedazos = pedazos_patilla.instantiate()	
			
		# Solo instanciamos las mitades si reconoció el objeto
		if pedazos != null:
			pedazos.global_position = body.global_position
			get_tree().current_scene.call_deferred("add_child", pedazos)
			
		get_tree().current_scene.sumar_punto()
		body.queue_free()
	
	elif body.is_in_group("bomba"):
		# Le avisamos al nivel principal que reste una vida
		get_tree().current_scene.restar_vida()
		
		# Destruimos la bomba para que no siga cayendo
		body.queue_free()
