## Harc szisztéma
## Kezeli az egységek közötti harcot, sérüléseket és támadásokat

extends Node

class_name CombatSystem

class AttackInfo:
	var attacker: Unit
	var target: Unit
	var damage: float
	var attack_range: float
	var attack_speed: float
	var is_attacking: bool = false
	var attack_cooldown: float = 0.0
	
	func _init(att: Unit, tgt: Unit) -> void:
		attacker = att
		target = tgt
		damage = att.get_attack_damage()
		attack_range = att.get_attack_range()
		attack_speed = att.get_attack_speed()

var unit: Unit
var current_target: Unit = null
var attack_info: AttackInfo = null
var attack_timer: float = 0.0

@export var base_damage: float = 10.0
@export var attack_range: float = 5.0
@export var attack_speed: float = 1.0  # Másodpercentként

func _ready() -> void:
	unit = get_parent()

func _process(delta: float) -> void:
	if not current_target:
		return
	
	# Cél távolságának ellenőrzése
	var distance = unit.global_position.distance_to(current_target.global_position)
	
	if distance > attack_range:
		# Túl messze - mozgatás a cél felé
		unit.move_to(current_target.global_position)
		return
	
	# Támadási cooldown csökkentése
	attack_timer -= delta
	
	if attack_timer <= 0:
		execute_attack(current_target)
		attack_timer = 1.0 / attack_speed

func set_target(target: Unit) -> void:
	if not target:
		current_target = null
		unit.stop_moving()
		return
	
	current_target = target
	print("%s támadás %s ellen!" % [unit.unit_name, target.unit_name])
	attack_timer = 0.0

func execute_attack(target: Unit) -> void:
	if not target or target.health <= 0:
		set_target(null)
		return
	
	var damage = calculate_damage()
	target.take_damage(damage)
	
	print("%s támadás: %s -> %s (%.1f sérülés)" % [unit.unit_name, unit.unit_name, target.unit_name, damage])
	
	# Ellentámadás
	if target.has_method("counter_attack"):
		target.counter_attack(unit)

func calculate_damage() -> float:
	var variance = randf_range(0.8, 1.2)
	return base_damage * variance

func get_is_attacking() -> bool:
	return current_target != null

func get_current_target() -> Unit:
	return current_target

func stop_attacking() -> void:
	set_target(null)

# Szükséges Unit metódusok
func _setup_unit_combat() -> void:
	if not unit:
		return
	
	# Ez a Unit scripten kerül meghívásra
	if not unit.has_method("get_attack_damage"):
		unit.set_meta("attack_damage", base_damage)
	if not unit.has_method("get_attack_range"):
		unit.set_meta("attack_range", attack_range)
	if not unit.has_method("get_attack_speed"):
		unit.set_meta("attack_speed", attack_speed)
