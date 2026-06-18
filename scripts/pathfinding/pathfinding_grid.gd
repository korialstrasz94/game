## Pathfinding grid rendszer
## Kezeli a térképet, navigálható cellákat és útvonalak cache-elését

extends Node

class_name PathfindingGrid

var pathfinder: AStarPathfinder
var grid_size: Vector2i = Vector2i(100, 100)
var cell_size: float = 1.0
var walkable_cells: Array[Vector2i] = []
var path_cache: Dictionary = {}  # (start, goal) -> path

@export var use_cache: bool = true
@export var debug_grid: bool = false

func _ready() -> void:
	pathfinder = AStarPathfinder.new()
	initialize_grid()

func initialize_grid() -> void:
	# Alapvetően az összes cella navigálható (később akadályok hozzáadása)
	walkable_cells.clear()
	
	for x in range(grid_size.x):
		for z in range(grid_size.z):
			walkable_cells.append(Vector2i(x, z))
	
	pathfinder.set_grid(grid_size, walkable_cells, cell_size)
	path_cache.clear()

func add_obstacle(world_pos: Vector3, radius: float = 2.0) -> void:
	var grid_pos = world_to_grid(world_pos)
	var radius_cells = int(radius / cell_size) + 1
	
	for x in range(-radius_cells, radius_cells + 1):
		for z in range(-radius_cells, radius_cells + 1):
			var obstacle_pos = grid_pos + Vector2i(x, z)
			if walkable_cells.has(obstacle_pos):
				walkable_cells.erase(obstacle_pos)
	
	pathfinder.set_grid(grid_size, walkable_cells, cell_size)
	path_cache.clear()

func remove_obstacle(world_pos: Vector3, radius: float = 2.0) -> void:
	var grid_pos = world_to_grid(world_pos)
	var radius_cells = int(radius / cell_size) + 1
	
	for x in range(-radius_cells, radius_cells + 1):
		for z in range(-radius_cells, radius_cells + 1):
			var obstacle_pos = grid_pos + Vector2i(x, z)
			if not walkable_cells.has(obstacle_pos):
				if obstacle_pos.x >= 0 and obstacle_pos.x < grid_size.x and \
				   obstacle_pos.y >= 0 and obstacle_pos.y < grid_size.z:
					walkable_cells.append(obstacle_pos)
	
	pathfinder.set_grid(grid_size, walkable_cells, cell_size)
	path_cache.clear()

func find_path(start_world: Vector3, goal_world: Vector3) -> Array[Vector3]:
	var start_grid = world_to_grid(start_world)
	var goal_grid = world_to_grid(goal_world)
	
	# Cache keresés
	if use_cache:
		var cache_key = str(start_grid) + "_" + str(goal_grid)
		if cache_key in path_cache:
			return path_cache[cache_key]
	
	# Pathfinding
	var grid_path = pathfinder.find_path(start_grid, goal_grid)
	
	if grid_path.is_empty():
		return []
	
	# Grid pozíciókat világpozícióvá konvertálás
	var world_path: Array[Vector3] = []
	for grid_pos in grid_path:
		world_path.append(pathfinder.grid_to_world(grid_pos))
	
	# Cache-elés
	if use_cache:
		var cache_key = str(start_grid) + "_" + str(goal_grid)
		path_cache[cache_key] = world_path
	
	return world_path

func world_to_grid(world_pos: Vector3) -> Vector2i:
	return pathfinder.world_to_grid(world_pos)

func grid_to_world(grid_pos: Vector2i) -> Vector3:
	return pathfinder.grid_to_world(grid_pos)

func set_grid_size(size: Vector2i, new_cell_size: float = 1.0) -> void:
	grid_size = size
	cell_size = new_cell_size
	initialize_grid()

func is_walkable(world_pos: Vector3) -> bool:
	var grid_pos = world_to_grid(world_pos)
	return pathfinder.is_walkable(grid_pos)

func clear_cache() -> void:
	path_cache.clear()

func _draw() -> void:
	if not debug_grid:
		return
	
	# Debug rács rajzolása
	for x in range(0, grid_size.x, 5):
		for z in range(0, grid_size.z, 5):
			var pos = Vector3(x * cell_size, 0.1, z * cell_size)
			var color = Color.GREEN if Vector2i(x, z) in walkable_cells else Color.RED
			# Godot 4-ben 3D debug rajzolás a DebugDraw3D vagy saját implementáció kell
