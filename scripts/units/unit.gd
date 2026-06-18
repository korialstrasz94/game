## Alap egység script
## Kezeli az egység adatait, kijelöléseit és vizuális visszajelzéseket

extends Node3D

class_name Unit

@export var unit_name: String = "Egység"
@export var health: float = 100.0
@export var max_health: float = 100.0
@export var speed: float = 10.0
@export var model_scale: float = 1.0

var is_selected: bool = false
var selection_indicator: Node3D

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

func is_unit() -> bool:
	return true

func get_unit_name() -> String:
	return unit_name

func take_damage(damage: float) -> void:
	health = max(0, health - damage)
	if health <= 0:
		queue_free()

func move_to(position: Vector3) -> void:
	# Ez később lesz implementálva
	pass
