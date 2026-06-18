## Kamera vezérlő - Warcraft 3 stílus
## Támogatja: WASD mozgást, egér szélsőség mozgást, zoomot

extends Camera3D

@export var camera_speed: float = 50.0
@export var edge_scroll_speed: float = 50.0
@export var edge_scroll_margin: int = 20
@export var zoom_speed: float = 5.0
@export var min_zoom: float = 10.0
@export var max_zoom: float = 100.0
@export var camera_height: float = 30.0
@export var camera_distance: float = 30.0

var target_position: Vector3
var target_zoom: float

func _ready() -> void:
	target_position = global_position
	target_zoom = size

func _process(delta: float) -> void:
	var input_direction = Vector3.ZERO
	
	# WASD input
	if Input.is_action_pressed("camera_up"):
		input_direction.z -= 1
	if Input.is_action_pressed("camera_down"):
		input_direction.z += 1
	if Input.is_action_pressed("camera_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("camera_right"):
		input_direction.x += 1
	
	# Egér szélsőség mozgás
	var mouse_pos = get_viewport().get_mouse_position()
	var viewport_size = get_viewport().get_visible_rect().size
	
	if mouse_pos.x < edge_scroll_margin:
		input_direction.x -= 1
	elif mouse_pos.x > viewport_size.x - edge_scroll_margin:
		input_direction.x += 1
	
	if mouse_pos.y < edge_scroll_margin:
		input_direction.z -= 1
	elif mouse_pos.y > viewport_size.y - edge_scroll_margin:
		input_direction.z += 1
	
	# Kamera mozgatása
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
		target_position += input_direction * camera_speed * delta
	
	# Zoom
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
		target_zoom = clamp(target_zoom - zoom_speed, min_zoom, max_zoom)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
		target_zoom = clamp(target_zoom + zoom_speed, min_zoom, max_zoom)
	
	# Sima mozgás és zoom
	global_position = global_position.lerp(target_position + Vector3(0, camera_height, -camera_distance), 5.0 * delta)
	size = lerp(size, target_zoom, 5.0 * delta)
	
	# Kamera körül néz
	look_at(target_position + Vector3(0, 0, 0), Vector3.UP)

func pan_to(position: Vector3) -> void:
	target_position = position
