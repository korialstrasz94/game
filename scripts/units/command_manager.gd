extends Camera3D # Or whatever node handles your input

# IMPORTANT: In the Godot Inspector, set your Ground Collision Layer to 1, 
# and your Unit Collision Layer to 2.

func _unhandled_input(event: InputEvent) -> void:
	# Detect Right Mouse Button click
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		issue_command()

func issue_command():
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	if not camera: return
	
	var space_state = get_world_3d().direct_space_state
	var origin = camera.project_ray_origin(mouse_pos)
	var end = origin + camera.project_ray_normal(mouse_pos) * 2000
	
	# 1. FIRST: Check if we clicked on a Unit (Assuming Units are on Physics Layer 2)
	var unit_query = PhysicsRayQueryParameters3D.create(origin, end)
	unit_query.collision_mask = 2 # Layer 2
	var unit_result = space_state.intersect_ray(unit_query)
	
	# If we hit a unit, and that unit is in the "enemies" group...
	if unit_result and unit_result.collider.is_in_group("enemies"):
		var target = unit_result.collider
		
		# Tell all selected units to attack this target
		for unit in GameManager.selected_units: # <-- Change this to your selection array!
			if unit.has_method("attack_target"):
				unit.attack_target(target)
		return # Stop here! Don't process a move command.
		
	# 2. SECOND: If we didn't click an enemy, check the Ground (Assuming Ground is Layer 1)
	var ground_query = PhysicsRayQueryParameters3D.create(origin, end)
	ground_query.collision_mask = 1 # Layer 1
	var ground_result = space_state.intersect_ray(ground_query)
	
	if ground_result:
		var target_pos = ground_result.position
		var queue_command = Input.is_key_pressed(KEY_SHIFT) # Shift+RightClick queues the move
		
		# Tell all selected units to move to the clicked position
		for unit in GameManager.selected_units: # <-- Change this to your selection array!
			if unit.has_method("move_to"):
				unit.move_to(target_pos, queue_command)