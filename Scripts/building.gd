extends Area2D

var nearby_building_spots : Array[Area2D]
var building_mode = [0]
var building_object

@onready var train = get_parent().get_parent().get_node("Train") #TEMP stupid way to get train for adding drills, find a better way
#@onready var hotbar = get_parent().get_parent().get_node("UI").get_node("Hotbar")
@export var hotbar : ButtonGroup

func _ready():
	for index in hotbar.get_buttons().size():
		var button = hotbar.get_buttons()[index]
		button.pressed.connect(func(): hotbar_pressed(index))
		button.get_parent().get_node("MarginContainer").get_node("KeyLabel").set_text(str(index+1))
	
func hotbar_pressed(index):
	index += 1
	hotbar_building_mode(index)


func _input(event : InputEvent):
	if(event.is_action_pressed("hotkey_1")):
		hotbar.get_buttons()[0].button_pressed = true
		hotbar_building_mode(1)
	if(event.is_action_pressed("hotkey_2")):
		hotbar.get_buttons()[1].button_pressed = true
		hotbar_building_mode(2)
	if(event.is_action_pressed("hotkey_3")):
		hotbar.get_buttons()[2].button_pressed = true
		hotbar_building_mode(3)
	if(event.is_action_pressed("hotkey_4")):
		hotbar.get_buttons()[3].button_pressed = true
		hotbar_building_mode(4)
	if(event.is_action_pressed("hotkey_5")):
		hotbar.get_buttons()[4].button_pressed = true
		hotbar_building_mode(5)
	if(event.is_action_pressed("hotkey_6")):
		hotbar.get_buttons()[5].button_pressed = true
		hotbar_building_mode(6)
	if(event.is_action_pressed("hotkey_7")):
		hotbar.get_buttons()[6].button_pressed = true
		hotbar_building_mode(7)
	if(event.is_action_pressed("hotkey_8")):
		hotbar.get_buttons()[7].button_pressed = true
		hotbar_building_mode(8)
	if(event.is_action_pressed("hotkey_9")):
		hotbar.get_buttons()[8].button_pressed = true
		hotbar_building_mode(9)
	if(event.is_action_pressed("ui_cancel")):
		change_building_mode([0])
		if hotbar.get_pressed_button():
			hotbar.get_pressed_button().button_pressed = false
	if event is InputEventMouseButton and event.is_pressed():
		if(nearby_building_spots.size() > 0):
			for spot in nearby_building_spots:
				if(spot.mouse_hover and not spot.blocked):
					build_on_spot(spot, building_object)

func hotbar_building_mode(mode):
	match mode:
		1: 
			change_building_mode([1])
			building_object = "res://Scenes/Buildings/cart.tscn"
		2:
			change_building_mode([2])
			building_object = "res://Scenes/Buildings/machine.tscn"
		3:
			change_building_mode([2])
			building_object = "res://Scenes/Buildings/drill.tscn"
		4:
			change_building_mode([3])
			building_object = "res://Scenes/Buildings/axle.tscn"
		5:
			change_building_mode([2])
			building_object = "res://Scenes/Buildings/motor.tscn"
		6:
			change_building_mode([3,4]) #TODO need multiple building modes for cog? (needs to be able to connect vertically to other cogs but also horizontally to axis
			building_object = "res://Scenes/Buildings/cog.tscn"
		7:
			change_building_mode([3])
			building_object = "res://Scenes/Buildings/bore.tscn"
		8:
			change_building_mode([5])
			building_object = "res://Scenes/Buildings/conveyor.tscn"


func change_building_mode(mode):
	building_mode = mode
	for area in nearby_building_spots:
		area.range_leave()
	nearby_building_spots.clear()
	for area in get_overlapping_areas():
		area_check(area)

func build_on_spot(bs, building):
	var new_machine = load(building).instantiate()
	bs.add_child(new_machine)
	_on_area_exited(bs)
	bs.occupy()
	if building == "res://Scenes/Buildings/drill.tscn":
		train.add_drill(new_machine)
	if building == "res://Scenes/Buildings/bore.tscn":
		train.add_drill(new_machine)


func _on_area_entered(area : Area2D):
	area_check(area)

func area_check(area):
	if(building_mode.has(area.spot_type)):
		nearby_building_spots.push_back(area)
		area.range_enter()

func _on_area_exited(area : Area2D):
	nearby_building_spots.erase(area)
	area.range_leave()
