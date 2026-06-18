## Egység mozgatási kontroller
## Kezeli az egység mozgatását az útvonal mentén, steering-gel és animációval

extends Node

class_name MovementController

signal move_started(target: Vector3)
signal move_finished(position: Vector3)

var unit: Unit
var current_path: Array[Vector3] = []
var path_index: int = 0
var is_moving: bool = false
var target_position: Vector3

@export var movement_speed: float = 10.0
@export var stop_distance: float = 0.5
@export var path_recalculate_distance: float = 2.0
@export var animation_smoothing: float = 0.15  # Lerp alpha

var pathfinding_grid: PathfindingGrid
var steering_controller: SteeringController
var last_position: Vector3

func _ready() -> void:
	unit = get_parent()
	movement_speed = unit.speed
	last_position = unit.global_position
	
	# PathfindingGrid megkeresése
	var root = get_tree().root.get_child(0)
	pathfinding_grid = root.find_child("PathfindingGrid", true, false)
	
	# SteeringController hozzáadása
	steering_controller = SteeringController.new()
	steering_controller.name = "SteeringController"
	steering_controller.use_steering = true
	steering_controller.separation_distance = 2.0
	add_child(steering_controller)
	steering_controller.add_unit_to_group()
	
	if not pathfinding_grid:
		push_warning("PathfindingGrid nem található! Pathfinding nem működik.")

func _process(delta: float) -> void:
	if not is_moving or current_path.is_empty():
		return
	
	move_along_path(delta)

func move_to(target: Vector3) -> bool:
	if not pathfinding_grid:
		push_error("PathfindingGrid nincs inicializálva")
		return false
	
	# Útvonalkeresés
	var path = pathfinding_grid.find_path(unit.global_position, target)
	
	if path.is_empty():
		print("Nincs útvonal a(z) %s számára a következő helyhez: %s" % [unit.unit_name, target])
		return false
	
	current_path = path
	path_index = 0
	target_position = target
	is_moving = true
	
	move_started.emit(target)
	print("%s mozgása: %d pont az útvonalban" % [unit.unit_name, path.size()])
	return true

func move_along_path(delta: float) -> void:
	if path_index >= current_path.size():
		is_moving = false
		print("%s elért a céljához" % unit.unit_name)
		move_finished.emit(target_position)
		return
	
	var next_waypoint = current_path[path_index]
	var direction = (next_waypoint - unit.global_position).normalized()
	
	# Steering alkalmazása ütközéskerülésre
	var steering = Vector3.ZERO
	if steering_controller:
		steering = steering_controller.get_steering_adjustment()
	
	var combined_direction = (direction + steering * 0.3).normalized()
	var distance = unit.global_position.distance_to(next_waypoint)
	
	# Mozgatás smooth animációval
	if distance > stop_distance:
		var new_position = unit.global_position + combined_direction * movement_speed * delta
		unit.global_position = new_position.lerp(last_position, animation_smoothing)
		last_position = new_position
		
		# Forgás az irányba (smooth)
		var target_direction = combined_direction
		var look_target = unit.global_position + target_direction
		unit.look_at(look_target, Vector3.UP)
	else:
		path_index += 1

func stop_moving() -> void:
	is_moving = false
	current_path.clear()
	path_index = 0

func get_is_moving() -> bool:
	return is_moving

func get_current_path() -> Array[Vector3]:
	return current_path.duplicate()

func clear_path() -> void:
	current_path.clear()
	path_index = 0
	is_moving = false

