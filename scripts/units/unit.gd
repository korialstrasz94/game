## Alap egység script
## Kezeli az egység adatait, kijelöléseit és vizuális visszajelzéseket

extends Node3D

class_name Unit

signal move_started(target: Vector3)
signal move_finished(position: Vector3)
signal selection_changed(selected: bool)
signal health_changed(current: float, max: float)
signal attack_started(target: Unit)
signal attack_finished()

@export var unit_name: String = "Egység"
@export var health: float = 100.0
@export var max_health: float = 100.0
@export var speed: float = 10.0
@export var model_scale: float = 1.0
@export var attack_damage: float = 10.0
@export var attack_range: float = 5.0
@export var attack_speed: float = 1.0

var is_selected: bool = false
var selection_indicator: Node3D
var movement_controller: MovementController
var command_queue: CommandQueue
var combat_system: CombatSystem

@onready var mesh_instance = MeshInstance3D.new()

func _ready() -> void:
	# Egyszerű mesh létrehozása
	var mesh = BoxMesh.new()
	mesh.size = Vector3(1, 2, 1) * model_scale
	mesh_instance.mesh = mesh
	add_child(mesh_instance)
	
	# Kijelölés indikátor
	create_selection_indicator()
	
	# Anyag beállítása
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.GRAY
	mesh_instance.set_surface_override_material(0, material)
	
	# Mozgatási kontroller hozzáadása
	movement_controller = MovementController.new()
	movement_controller.name = "MovementController"
	movement_controller.speed = speed
	add_child(movement_controller)
	movement_controller.move_started.connect(_on_move_started)
	movement_controller.move_finished.connect(_on_move_finished)
	
	# Parancsüzenetsor hozzáadása
	command_queue = CommandQueue.new()
	command_queue.name = "CommandQueue"
	add_child(command_queue)
	
	# Harc szisztéma hozzáadása
	combat_system = CombatSystem.new()
	combat_system.name = "CombatSystem"
	combat_system.base_damage = attack_damage
	combat_system.attack_range = attack_range
	combat_system.attack_speed = attack_speed
	add_child(combat_system)

func _process(_delta: float) -> void:
	if is_selected and selection_indicator:
		# Forgó hatás a kijelöléshez
		selection_indicator.rotation.y += 0.02

func create_selection_indicator() -> void:
	selection_indicator = Node3D.new()
	selection_indicator.name = "SelectionIndicator"
	add_child(selection_indicator)
	
	var torus = MeshInstance3D.new()
	var torus_mesh = TorusMesh.new()
	torus_mesh.inner_radius = 0.8
	torus_mesh.outer_radius = 1.2
	torus.mesh = torus_mesh
	
	var glow_material = StandardMaterial3D.new()
	glow_material.albedo_color = Color.GREEN
	glow_material.emission_enabled = true
	glow_material.emission = Color.GREEN
	glow_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	glow_material.alpha_scissor = BaseMaterial3D.ALPHA_SCISSOR_OPAQUE
	torus.set_surface_override_material(0, glow_material)
	
	selection_indicator.add_child(torus)
	set_selected(false)

func set_selected(selected: bool) -> void:
	is_selected = selected
	if selection_indicator:
		selection_indicator.visible = selected
	selection_changed.emit(selected)

func is_unit() -> bool:
	return true

func get_unit_name() -> String:
	return unit_name

func get_attack_damage() -> float:
	return attack_damage

func get_attack_range() -> float:
	return attack_range

func get_attack_speed() -> float:
	return attack_speed

func take_damage(damage: float) -> void:
	health = max(0, health - damage)
	health_changed.emit(health, max_health)
	if health <= 0:
		die()

func die() -> void:
	print("%s meghalt!" % unit_name)
	queue_free()

func move_to(position: Vector3) -> void:
	if movement_controller:
		movement_controller.move_to(position)
		move_started.emit(position)

func stop_moving() -> void:
	if movement_controller:
		movement_controller.stop_moving()

func attack(target: Unit) -> void:
	if combat_system:
		combat_system.set_target(target)
		attack_started.emit(target)

func stop_attacking() -> void:
	if combat_system:
		combat_system.stop_attacking()

func counter_attack(attacker: Unit) -> void:
	# Ellentámadás - 50% eséllyel
	if randf() < 0.5:
		print("%s visszaütésben támad!" % unit_name)
		var counter_damage = attack_damage * 0.5
		attacker.take_damage(counter_damage)

func is_moving() -> bool:
	if movement_controller:
		return movement_controller.get_is_moving()
	return false

func _on_move_started(target: Vector3) -> void:
	move_started.emit(target)

func _on_move_finished(position: Vector3) -> void:
	move_finished.emit(position)
