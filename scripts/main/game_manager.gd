## Fő játékjelenet
## Kezeli a játék inicializálását, kameráját és jeleneteit

extends Node3D

class_name GameManager

var unit_selection: Node
var camera_controller: Camera3D
var pathfinding_grid: PathfindingGrid
var building_manager: BuildingManager

@onready var units_container = Node3D.new()

func _ready() -> void:
	# Jelenet felépítése
	setup_scene()
	
	# Pathfinding grid létrehozása
	pathfinding_grid = PathfindingGrid.new()
	pathfinding_grid.name = "PathfindingGrid"
	pathfinding_grid.grid_size = Vector2i(200, 200)
	pathfinding_grid.cell_size = 1.0
	add_child(pathfinding_grid)
	
	# Épület menedzser létrehozása
	building_manager = BuildingManager.new()
	building_manager.name = "BuildingManager"
	add_child(building_manager)
	
	# Kijelölési menedzser
	unit_selection = CanvasLayer.new()
	unit_selection.name = "SelectionLayer"
	add_child(unit_selection)
	
	var selection_manager = Node.new()
	selection_manager.name = "UnitSelection"
	selection_manager.set_script(load("res://scripts/selection/unit_selection.gd"))
	unit_selection.add_child(selection_manager)
	
	# Kamera
	camera_controller = Camera3D.new()
	camera_controller.name = "Camera3D"
	camera_controller.set_script(load("res://scripts/camera/camera_controller.gd"))
	camera_controller.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera_controller.size = 40.0
	camera_controller.global_position = Vector3(0, 30, -30)
	add_child(camera_controller)
	camera_controller.make_current()
	
	# Egységek konténere
	units_container.name = "Units"
	add_child(units_container)
	
	# Demo egységek létrehozása
	spawn_demo_units()
	
	# Demo épületek létrehozása
	spawn_demo_buildings()

func setup_scene() -> void:
	# Közvetlen megvilágítás
	var directional_light = DirectionalLight3D.new()
	directional_light.global_position = Vector3(50, 50, 50)
	directional_light.rotation = Vector3(-PI/4, PI/4, 0)
	directional_light.energy = 2.0
	add_child(directional_light)
	
	# Pálya (sík sík)
	var ground_mesh = MeshInstance3D.new()
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(200, 200)
	ground_mesh.mesh = plane_mesh
	
	var ground_material = StandardMaterial3D.new()
	ground_material.albedo_color = Color.GREEN * 0.7
	ground_mesh.set_surface_override_material(0, ground_material)
	
	add_child(ground_mesh)
	
	# Ütközési alak a talajnak
	var ground_static = StaticBody3D.new()
	ground_static.name = "Ground"
	var collision_shape = CollisionShape3D.new()
	var box_shape = BoxShape3D.new()
	box_shape.size = Vector3(200, 1, 200)
	collision_shape.shape = box_shape
	collision_shape.global_position = Vector3(0, -1, 0)
	ground_static.add_child(collision_shape)
	add_child(ground_static)

func spawn_demo_units() -> void:
	# Néhány demo egység létrehozása
	var unit_scene = load("res://scenes/units/unit.tscn")
	
	if not unit_scene:
		push_error("Unit jelenet nem található!")
		return
	
	# Egységek pozíciói
	var positions = [
		Vector3(-10, 0, -10),
		Vector3(-5, 0, -10),
		Vector3(0, 0, -10),
		Vector3(5, 0, -10),
		Vector3(10, 0, -10),
		Vector3(-10, 0, -5),
		Vector3(10, 0, -5),
	]
	
	for pos in positions:
		var unit = unit_scene.instantiate()
		unit.global_position = pos
		units_container.add_child(unit)

func _input(event: InputEvent) -> void:
	# Jobbkattintás: mozgatás (később implementálva)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var selected_units = get_selected_units()
			if selected_units.size() > 0:
				var target_pos = get_mouse_world_position()
				move_units_to(selected_units, target_pos)

func get_selected_units() -> Array:
	var selection = find_child("UnitSelection", true, false)
	if selection and selection.has_method("get_selected_units"):
		return selection.get_selected_units()
	return []

func move_units_to(units: Array, target: Vector3) -> void:
	# Egyenlőre csak info
	print("Egységek mozgatása: ", units.size(), " a következő helyre: ", target)
	for unit in units:
		if unit.has_method("move_to"):
			unit.move_to(target)

func spawn_demo_buildings() -> void:
	# Demo épületek létrehozása
	if building_manager:
		var building1 = building_manager.create_building("Kastély", Vector3(50, 0, 50), 300, 200)
		var building2 = building_manager.create_building("Laktanya", Vector3(-40, 0, 40), 200, 150)
		var building3 = building_manager.create_building("Aranyfejtő", Vector3(30, 0, -30), 150, 100)
		
		print("Demo épületek letrehozva")

func get_mouse_world_position() -> Vector3:
	var mouse_pos = get_viewport().get_mouse_position()
	var plane = Plane(Vector3.UP, 0)
	var ray_from = camera_controller.project_ray_origin(mouse_pos)
	var ray_dir = camera_controller.project_ray_normal(mouse_pos)
	var intersection = plane.intersects_ray(ray_from, ray_dir)
	
	if intersection != null:
		return intersection
	return Vector3.ZERO

func _process(_delta: float) -> void:
	# UI-t frissíteni lehet itt
	pass
