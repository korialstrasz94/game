## Épület alap script
## Kezeli az épület adatait, konstruálását és vizuális megjelenítését

extends Node3D

class_name Building

signal construction_started()
signal construction_finished()
signal damaged(damage: float)
signal destroyed()

@export var building_name: String = "Épület"
@export var health: float = 500.0
@export var max_health: float = 500.0
@export var build_time: float = 30.0
@export var gold_cost: int = 200
@export var wood_cost: int = 100
@export var model_scale: float = 1.5

var is_selected: bool = false
var is_constructing: bool = false
var construction_progress: float = 0.0
var selection_indicator: Node3D

@onready var mesh_instance = MeshInstance3D.new()

func _ready() -> void:
	# Mesh létrehozása
	var mesh = BoxMesh.new()
	mesh.size = Vector3(2, 2, 2) * model_scale
	mesh_instance.mesh = mesh
	add_child(mesh_instance)
	
	# Kijelölés indikátor
	create_selection_indicator()
	
	# Anyag beállítása
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.DARK_GRAY
	mesh_instance.set_surface_override_material(0, material)
	
	# Konstruálás elkezdése
	start_construction()

func _process(delta: float) -> void:
	if is_constructing:
		construction_progress += delta / build_time
		if construction_progress >= 1.0:
			finish_construction()
		update_construction_visualization()

func start_construction() -> void:
	is_constructing = true
	construction_progress = 0.0
	construction_started.emit()
	print("%s építés kezdődött" % building_name)

func finish_construction() -> void:
	is_constructing = false
	construction_progress = 1.0
	construction_finished.emit()
	print("%s építés befejezve!" % building_name)
	update_material_color(Color.GRAY)

func update_construction_visualization() -> void:
	# Eltűnés a konstruálás közben
	if mesh_instance.material_override:
		var mat = mesh_instance.material_override as StandardMaterial3D
		mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		mat.alpha_scissor = BaseMaterial3D.ALPHA_SCISSOR_OPAQUE
		mat.modulate.a = 0.3 + construction_progress * 0.7

func update_material_color(new_color: Color) -> void:
	var material = StandardMaterial3D.new()
	material.albedo_color = new_color
	material.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED
	mesh_instance.set_surface_override_material(0, material)

func create_selection_indicator() -> void:
	selection_indicator = Node3D.new()
	selection_indicator.name = "SelectionIndicator"
	add_child(selection_indicator)
	
	var cube = MeshInstance3D.new()
	var cube_mesh = BoxMesh.new()
	cube_mesh.size = Vector3(2.5, 2.5, 2.5) * model_scale
	cube.mesh = cube_mesh
	
	var glow_material = StandardMaterial3D.new()
	glow_material.albedo_color = Color.YELLOW
	glow_material.emission_enabled = true
	glow_material.emission = Color.YELLOW * 0.5
	glow_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	cube.set_surface_override_material(0, glow_material)
	
	selection_indicator.add_child(cube)
	set_selected(false)

func set_selected(selected: bool) -> void:
	is_selected = selected
	if selection_indicator:
		selection_indicator.visible = selected

func take_damage(damage: float) -> void:
	if is_constructing:
		return
	
	health = max(0, health - damage)
	
	# Szín változás sérülés alapján
	var health_percent = health / max_health
	var color = Color.GRAY.lerp(Color.RED, 1.0 - health_percent)
	update_material_color(color)
	
	damaged.emit(damage)
	print("%s sérülést szenvedett. HP: %.0f/%.0f" % [building_name, health, max_health])
	
	if health <= 0:
		destroy()

func destroy() -> void:
	print("%s megsemmisült!" % building_name)
	destroyed.emit()
	queue_free()

func get_construction_progress() -> float:
	return construction_progress

func is_fully_constructed() -> bool:
	return construction_progress >= 1.0
