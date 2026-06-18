## Parancsüzenetsor
## Kezeli az egységeknek adott parancsok sorrendjét és végrehajtását

extends Node

class_name CommandQueue

class Command:
	var command_type: String
	var target: Vector3
	var duration: float = 0.0
	var elapsed: float = 0.0
	
	func _init(type: String, pos: Vector3 = Vector3.ZERO) -> void:
		command_type = type
		target = pos

var unit: Unit
var command_queue: Array[Command] = []
var current_command: Command = null
var is_executing: bool = false

func _ready() -> void:
	unit = get_parent()

func _process(delta: float) -> void:
	if command_queue.is_empty() and not is_executing:
		return
	
	if not is_executing and command_queue.size() > 0:
		execute_next_command()
	
	if is_executing and current_command:
		update_current_command(delta)

func add_command(command_type: String, target: Vector3 = Vector3.ZERO) -> void:
	var cmd = Command.new(command_type, target)
	command_queue.append(cmd)
	print("Parancs hozzáadva: %s (%d a sorban)" % [command_type, command_queue.size()])

func add_move_command(target: Vector3) -> void:
	add_command("move", target)

func add_attack_command(target_unit: Unit) -> void:
	add_command("attack", target_unit.global_position)

func add_wait_command(seconds: float) -> void:
	var cmd = Command.new("wait")
	cmd.duration = seconds
	command_queue.append(cmd)

func execute_next_command() -> void:
	if command_queue.is_empty():
		is_executing = false
		return
	
	current_command = command_queue.pop_front()
	is_executing = true
	
	match current_command.command_type:
		"move":
			print("%s vezénylés: Mozgatás %s felé" % [unit.unit_name, current_command.target])
			unit.move_to(current_command.target)
		"attack":
			print("%s vezénylés: Támadás %s felé" % [unit.unit_name, current_command.target])
		"wait":
			print("%s vezénylés: Várakozás %f másodpercig" % [unit.unit_name, current_command.duration])

func update_current_command(delta: float) -> void:
	if not current_command:
		return
	
	match current_command.command_type:
		"move":
			if not unit.is_moving():
				command_finished()
		"wait":
			current_command.elapsed += delta
			if current_command.elapsed >= current_command.duration:
				command_finished()
		"attack":
			command_finished()

func command_finished() -> void:
	print("Parancs befejezve: %s" % current_command.command_type)
	current_command = null
	is_executing = false
	
	if command_queue.size() > 0:
		execute_next_command()

func clear_queue() -> void:
	command_queue.clear()
	current_command = null
	is_executing = false

func get_queue_size() -> int:
	return command_queue.size()

func queue_commands(commands: Array) -> void:
	for cmd in commands:
		add_command(cmd["type"], cmd.get("target", Vector3.ZERO))
