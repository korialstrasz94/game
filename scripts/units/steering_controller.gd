## Steering & Ütközéskerülés
## Egységek közötti ütközéskerülés és steering viselkedés

extends Node

class_name SteeringController

var unit: Unit
var nearby_units: Array = []
var separation_radius: float = 2.0
var separation_force: float = 5.0
var max_steering_force: float = 10.0

@export var use_steering: bool = true
@export var separation_distance: float = 2.0
@export var view_radius: float = 10.0

func _ready() -> void:
	unit = get_parent()

func _process(_delta: float) -> void:
	if not use_steering:
		return
	
	# Közeli egységek keresése
	find_nearby_units()

func find_nearby_units() -> void:
	nearby_units.clear()
	var root = get_tree().root.get_child(0)
	var units_node = root.find_child("Units", true, false)
	
	if not units_node:
		return
	
	for other_unit in units_node.get_children():
		if other_unit != unit and other_unit.is_in_group("units"):
			var distance = unit.global_position.distance_to(other_unit.global_position)
			if distance < view_radius and distance > 0:
				nearby_units.append({
					"unit": other_unit,
					"distance": distance,
					"position": other_unit.global_position
				})

func calculate_separation_force() -> Vector3:
	var steer = Vector3.ZERO
	
	if nearby_units.is_empty():
		return steer
	
	for nearby in nearby_units:
		var distance = nearby["distance"]
		if distance < separation_distance:
			# Távolodási erő
			var diff = unit.global_position - nearby["position"]
			diff = diff.normalized()
			diff /= distance
			steer += diff
	
	if steer.length() > 0:
		steer = steer.normalized() * max_steering_force
	
	return steer

func get_steering_adjustment() -> Vector3:
	return calculate_separation_force()

func add_unit_to_group() -> void:
	if not unit.is_in_group("units"):
		unit.add_to_group("units")
