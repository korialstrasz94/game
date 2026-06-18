## Egység kijelölési menedzser
## Kezeli az egységek kijelölését, deselektálását és a kijelölési UI-t

extends Node

signal units_selected(units: Array)
signal selection_cleared()

var selected_units: Array = []
var selection_box_start: Vector2 = Vector2.ZERO
var is_selecting: bool = false
var camera: Camera3D

@export var selection_box_color: Color = Color(0, 1, 0, 0.3)
@export var selection_box_outline_color: Color = Color(0, 1, 0, 1.0)

func _ready() -> void:
	camera = get_tree().root.get_child(0).find_child("Camera3D", true, false)
	if not camera:
		push_error("Camera3D nem található!")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				selection_box_start = event.position
				is_selecting = true
			else:
				is_selecting = false
				var selection_box_end = event.position
				select_units_in_box(selection_box_start, selection_box_end)
	
	elif event is InputEventMouseMotion:
		if is_selecting:
			queue_redraw()

func _draw() -> void:
	if is_selecting:
		var current_mouse_pos = get_local_mouse_position()
		var rect = Rect2(selection_box_start, current_mouse_pos - selection_box_start)
		rect = rect.abs()
		draw_rect(rect, selection_box_color)
		draw_rect(rect, selection_box_outline_color, false, 2.0)

func select_units_in_box(from: Vector2, to: Vector2) -> void:
	var rect = Rect2(from, to - from).abs()
	var shift_pressed = Input.is_action_pressed("select_multiple")
	
	if not shift_pressed:
		deselect_all()
	
	var root = get_tree().root.get_child(0)
	var units = root.find_child("Units", true, false)
	
	if units:
		for unit in units.get_children():
			if unit.has_method("is_unit"):
				var screen_pos = camera.unproject_position(unit.global_position)
				if rect.has_point(screen_pos):
					select_unit(unit)

func select_unit(unit: Node) -> void:
	if unit not in selected_units:
		selected_units.append(unit)
		if unit.has_method("set_selected"):
			unit.set_selected(true)
		units_selected.emit(selected_units)

func deselect_unit(unit: Node) -> void:
	if unit in selected_units:
		selected_units.erase(unit)
		if unit.has_method("set_selected"):
			unit.set_selected(false)
		units_selected.emit(selected_units)

func deselect_all() -> void:
	for unit in selected_units:
		if unit.has_method("set_selected"):
			unit.set_selected(false)
	selected_units.clear()
	selection_cleared.emit()

func get_selected_units() -> Array:
	return selected_units.duplicate()
