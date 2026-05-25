extends Line2D

# 1. LAS VARIABLES (Tienen que ir siempre arriba del todo)
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

# 4. SE EJECUTA TODO EL TIEMPO (Dibuja la línea y mueve la colisión)
func _process(_delta: float) -> void:
	var pos_raton = get_global_mouse_position()
	
	add_point(pos_raton)
	
	if points.size() > longitud_estela:
		remove_point(0)
		
	# Hace que el círculo de colisión siga a la punta de la línea
	$Area2D.global_position = pos_raton


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
