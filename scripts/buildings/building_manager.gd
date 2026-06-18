## Épület menedzser
## Kezeli az épületek kezelését, építési szimuláció és erőforrások

extends Node

class_name BuildingManager

signal building_constructed(building: Building)
signal building_destroyed(building: Building)

var buildings: Array[Building] = []
var selected_building: Building = null

@export var gold: int = 1000
@export var wood: int = 1000

var buildings_container: Node3D

func _ready() -> void:
	buildings_container = Node3D.new()
	buildings_container.name = "Buildings"
	get_parent().add_child(buildings_container)

func create_building(building_name: String, position: Vector3, gold_cost: int = 200, wood_cost: int = 100) -> Building:
	# Erőforrások ellenőrzése
	if gold < gold_cost or wood < wood_cost:
		print("Nem elég erőforrás! Arany: %d/%d, Fa: %d/%d" % [gold, gold_cost, wood, wood_cost])
		return null
	
	# Erőforrások levonása
	gold -= gold_cost
	wood -= wood_cost
	
	# Épület létrehozása
	var building = Building.new()
	building.name = building_name
	building.building_name = building_name
	building.global_position = position
	building.construction_finished.connect(_on_building_constructed.bindv([building]))
	building.destroyed.connect(_on_building_destroyed.bindv([building]))
	
	buildings_container.add_child(building)
	buildings.append(building)
	
	print("%s építés megkezdődött. Maradék arany: %d, Fa: %d" % [building_name, gold, wood])
	return building

func select_building(building: Building) -> void:
	if selected_building:
		selected_building.set_selected(false)
	
	selected_building = building
	if building:
		building.set_selected(true)

func deselect_building() -> void:
	if selected_building:
		selected_building.set_selected(false)
	selected_building = null

func _on_building_constructed(building: Building) -> void:
	print("Épület kész: %s" % building.building_name)
	building_constructed.emit(building)

func _on_building_destroyed(building: Building) -> void:
	buildings.erase(building)
	if selected_building == building:
		selected_building = null
	building_destroyed.emit(building)

func get_buildings() -> Array[Building]:
	return buildings.duplicate()

func add_resources(gold_amount: int, wood_amount: int) -> void:
	gold += gold_amount
	wood += wood_amount
	print("Erőforrások hozzáadva: +%d arany, +%d fa (Össz: %d, %d)" % [gold_amount, wood_amount, gold, wood])

func remove_resources(gold_amount: int, wood_amount: int) -> bool:
	if gold >= gold_amount and wood >= wood_amount:
		gold -= gold_amount
		wood -= wood_amount
		return true
	return false
