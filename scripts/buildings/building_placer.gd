extends Node3D # Attach to Camera3D or a top-level Node3D

@export var building_scene: PackedScene # Drag your building scene here in the inspector
@export var grid_size: float = 2.0      # Snap to grid (e.g., 2x2 meters)

var is_placing: bool = false
var ghost_building: Node3D = null
var can_place: bool = false

func _process(delta):
	if not is_placing or not ghost_building:
		return

	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	if not camera:
		return

	# Raycast from camera to the ground
	var space_state = get_world_3d().direct_space_state
	var origin = camera.project_ray_origin(mouse_pos)
	var end = origin + camera.project_ray_normal(mouse_pos) * 2000

	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collision_mask = 1 # Assuming ground is on layer 1
	var result = space_state.intersect_ray(query)

	if result:
		var pos = result.position
		
		# 1. Snap to Grid
		pos.x = round(pos.x / grid_size) * grid_size
		pos.z = round(pos.z / grid_size) * grid_size
		ghost_building.global_transform.origin = pos

		# 2. Check if area is valid (Simplified)
		# In a full game, the ghost_building should have an Area3D that checks for overlaps.
		# For now, we assume it's valid if it hits the ground.
		can_place = true 
		
		# TODO: Change ghost material to Green (valid) or Red (invalid) here

		# 3. Handle Input
		if Input.is_action_just_pressed("left_click") and can_place:
			place_building()
			
		if Input.is_action_just_pressed("right_click"):
			cancel_building()

func start_building():
	if is_placing:
		cancel_building()
		
	is_placing = true
	ghost_building = building_scene.instantiate()
	add_child(ghost_building)
	
	# TODO: Make the ghost transparent or change its material to a hologram effect
	# Example: ghost_building.set_surface_override_material(0, transparent_material)

func place_building():
	var actual_building = building_scene.instantiate()
	actual_building.global_transform = ghost_building.global_transform
	get_tree().current_scene.add_child(actual_building)
	cancel_building()

func cancel_building():
	if ghost_building:
		ghost_building.queue_free()
		ghost_building = null
	is_placing = false