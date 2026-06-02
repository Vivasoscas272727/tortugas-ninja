extends Line2D

# 1. LAS VARIABLES
var pedazos_pizza = preload("res://objeto_roto.tscn")
var pedazos_patilla = preload("res://patilla_roto.tscn")
var longitud_estela = 10 

var DATOS_ARMAS = {
	"katana": {"color": Color(0, 0.5, 1), "grosor": 8, "foto": preload("res://katana.png")},
	"bo": {"color": Color(0.6, 0, 0.8), "grosor": 1, "foto": preload("res://bo.png")},
	"nunchaku": {"color": Color(1, 0.6, 0), "grosor": 12,"foto": preload("res://nunchakus.png")},
	"sais": {"color": Color(1, 0.1, 0.1), "grosor": 6, "foto": preload("res://sais.png")}
}

var arma_actual = "katana" 

# 2. SE EJECUTA AL INICIAR
func _ready() -> void:
	cambiar_arma(Global.arma_seleccionada)

# 3. FUNCIÓN PARA CAMBIAR EL COLOR Y GROSOR
func cambiar_arma(nombre_arma: String) -> void:
	if DATOS_ARMAS.has(nombre_arma):
		arma_actual = nombre_arma
		self.default_color = DATOS_ARMAS[nombre_arma]["color"]
		self.width = DATOS_ARMAS[nombre_arma]["grosor"]
		$Area2D/FotoArma.texture = DATOS_ARMAS[nombre_arma]["foto"]
		print("Arma cambiada a: ", nombre_arma)

# 4. SE EJECUTA TODO EL TIEMPO
func _process(_delta: float) -> void:
	var pos_global = get_global_mouse_position()
	var pos_local = get_local_mouse_position()
	
	# Usamos la posición local para que la línea nunca se desfase
	add_point(pos_local)
	
	if points.size() > longitud_estela:
		remove_point(0)
		
	# Movemos la colisión y la foto usando la posición global
	$Area2D.global_position = pos_global

# 5. LÓGICA DE CORTAR Y EXPLOSIONES
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Comprobamos que el objeto tocado sea el original y no un pedazo suelto
	if body.is_in_group("enemigo"):
		var pedazos = null
		
		# Convertimos el nombre a minúsculas
		var nombre_objeto = body.name.to_lower()
		
		# SOLUCIÓN: Usamos 'in' para que detecte el objeto sin importar cuántos clones haya
		if body.is_in_group("es_pizza"):
			pedazos = pedazos_pizza.instantiate()
		elif body.is_in_group("es_patilla"):
			pedazos = pedazos_patilla.instantiate()
			
		# Solo instanciamos las mitades si reconoció el objeto
		if pedazos != null:
			pedazos.global_position = body.global_position
			get_tree().current_scene.call_deferred("add_child", pedazos)
			
		get_tree().current_scene.sumar_punto()
		body.queue_free()
	
	elif body.is_in_group("bomba"):
		get_tree().current_scene.restar_vida()
		body.queue_free()
