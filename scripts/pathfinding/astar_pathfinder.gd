## A* Pathfinding algoritmus
## Hatékony útvonalkeresés rácsbázisú térképen

extends Node

class_name AStarPathfinder

class Node_:
	var position: Vector2i
	var g_cost: float = 0.0  # Költség a starttól
	var h_cost: float = 0.0  # Heurisztikus költség a célig
	var f_cost: float = 0.0  # G + H
	var parent: Node_ = null
	
	func _init(pos: Vector2i) -> void:
		position = pos
	
	func calculate_f_cost() -> void:
		f_cost = g_cost + h_cost

var walkable_cells: Array[Vector2i] = []
var grid_size: Vector2i = Vector2i.ZERO
var cell_size: float = 1.0

# Heurisztikus függvény (Manhattan távolság)
func _heuristic(from: Vector2i, to: Vector2i) -> float:
	return abs(from.x - to.x) + abs(from.y - to.y) * 1.0

# Egyenes heurisztikus függvény (Euklideszi távolság)
func _heuristic_diagonal(from: Vector2i, to: Vector2i) -> float:
	var dx = abs(from.x - to.x)
	var dy = abs(from.y - to.y)
	return sqrt(dx*dx + dy*dy)

func set_grid(size: Vector2i, walkable: Array[Vector2i], cell_sz: float = 1.0) -> void:
	grid_size = size
	walkable_cells = walkable
	cell_size = cell_sz

func is_walkable(pos: Vector2i) -> bool:
	if pos.x < 0 or pos.x >= grid_size.x or pos.y < 0 or pos.y >= grid_size.y:
		return false
	return pos in walkable_cells

func get_neighbors(pos: Vector2i) -> Array[Vector2i]:
	var neighbors: Array[Vector2i] = []
	
	# 8-irányú mozgatás (vagy 4 közvetlen)
	var directions = [
		Vector2i.UP,
		Vector2i.DOWN,
		Vector2i.LEFT,
		Vector2i.RIGHT,
		Vector2i(1, 1),    # Diagonális
		Vector2i(1, -1),
		Vector2i(-1, 1),
		Vector2i(-1, -1)
	]
	
	for dir in directions:
		var neighbor = pos + dir
		if is_walkable(neighbor):
			neighbors.append(neighbor)
	
	return neighbors

func find_path(start: Vector2i, goal: Vector2i) -> Array[Vector2i]:
	if not is_walkable(start) or not is_walkable(goal):
		return []
	
	if start == goal:
		return [start]
	
	var open_set: Array[Node_] = []
	var closed_set: Array[Vector2i] = []
	var node_map: Dictionary = {}  # Vector2i -> Node_
	
	var start_node = Node_(start)
	start_node.g_cost = 0.0
	start_node.h_cost = _heuristic_diagonal(start, goal)
	start_node.calculate_f_cost()
	
	open_set.append(start_node)
	node_map[start] = start_node
	
	while open_set.size() > 0:
		# Legkisebb F cost-al rendelkező node megkeresése
		var current_index = 0
		for i in range(1, open_set.size()):
			if open_set[i].f_cost < open_set[current_index].f_cost:
				current_index = i
		
		var current = open_set[current_index]
		
		if current.position == goal:
			# Út megtalálva - visszafelé követés
			return _reconstruct_path(current)
		
		open_set.remove_at(current_index)
		closed_set.append(current.position)
		
		for neighbor_pos in get_neighbors(current.position):
			if neighbor_pos in closed_set:
				continue
			
			# Mozgatás költsége (diagonál drágább)
			var move_cost = 1.4 if abs(current.position.x - neighbor_pos.x) + abs(current.position.y - neighbor_pos.y) == 2 else 1.0
			var tentative_g = current.g_cost + move_cost
			
			if neighbor_pos in node_map:
				var neighbor_node = node_map[neighbor_pos]
				if tentative_g < neighbor_node.g_cost:
					neighbor_node.parent = current
					neighbor_node.g_cost = tentative_g
					neighbor_node.h_cost = _heuristic_diagonal(neighbor_pos, goal)
					neighbor_node.calculate_f_cost()
			else:
				var neighbor_node = Node_(neighbor_pos)
				neighbor_node.parent = current
				neighbor_node.g_cost = tentative_g
				neighbor_node.h_cost = _heuristic_diagonal(neighbor_pos, goal)
				neighbor_node.calculate_f_cost()
				
				open_set.append(neighbor_node)
				node_map[neighbor_pos] = neighbor_node
	
	# Nincs út
	return []

func _reconstruct_path(node: Node_) -> Array[Vector2i]:
	var path: Array[Vector2i] = []
	var current = node
	
	while current != null:
		path.insert(0, current.position)
		current = current.parent
	
	return path

func grid_to_world(grid_pos: Vector2i) -> Vector3:
	return Vector3(grid_pos.x * cell_size, 0, grid_pos.y * cell_size)

func world_to_grid(world_pos: Vector3) -> Vector2i:
	return Vector2i(int(world_pos.x / cell_size), int(world_pos.z / cell_size))
