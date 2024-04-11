extends Area2D

var nearby_building_spots : Array[Area2D]
var building_mode = [0]
var building_object

@export var inventory : Array[Item]

@onready var train = get_parent().get_parent().get_node("Train") #TEMP stupid way to get train for adding drills, find a better way
#@onready var hotbar = get_parent().get_parent().get_node("UI").get_node("Hotbar")
@export var hotbar : ButtonGroup

func _ready():
	for index in hotbar.get_buttons().size():
		var button = hotbar.get_buttons()[index]
		button.pressed.connect(func(): hotbar_pressed(index))
		button.get_parent().get_node("MarginContainer").get_node("KeyLabel").set_text(str(index+1))
		if index <= inventory.size()-1:
			button.get_parent().get_node("TextureRect").texture = inventory[index].icon
			button.get_parent().get_parent().visible = true
	
func hotbar_pressed(index):
	change_building_mode(inventory[index].building_mode)
	building_object = inventory[index].scene


func _input(event : InputEvent):
	var index = -1
	for i in range(9):
		if event.is_action_pressed("hotkey_" + str(i + 1)):
			index = i
			break
		
	if(event.is_action_pressed("ui_cancel")):
		change_building_mode([0])
		if hotbar.get_pressed_button():
			hotbar.get_pressed_button().button_pressed = false
			
	if index != -1:
		change_building_mode(inventory[index].building_mode)
		building_object = inventory[index].scene
		hotbar.get_buttons()[index].button_pressed = true		
	
	if event is InputEventMouseButton and event.is_pressed():
		if(nearby_building_spots.size() > 0):
			for spot in nearby_building_spots:
				if(spot.mouse_hover and not spot.blocked):
					build_on_spot(spot, building_object)

func change_building_mode(mode):
	building_mode = mode
	for area in nearby_building_spots:
		area.range_leave()
	nearby_building_spots.clear()
	for area in get_overlapping_areas():
		area_check(area)

func build_on_spot(bs, building):
	var new_machine = building.instantiate()
	bs.add_child(new_machine)
	_on_area_exited(bs)
	bs.occupy()
	if new_machine.name == "Drill" or new_machine.name == "Bore":
		train.add_drill(new_machine)
	#if building == "res://Scenes/Buildings/drill.tscn":
		#train.add_drill(new_machine)
	#if building == "res://Scenes/Buildings/bore.tscn":
		#train.add_drill(new_machine)


func _on_area_entered(area : Area2D):
	area_check(area)

func area_check(area):
	if(building_mode.has(area.spot_type)):
		nearby_building_spots.push_back(area)
		area.range_enter()

func _on_area_exited(area : Area2D):
	nearby_building_spots.erase(area)
	area.range_leave()
