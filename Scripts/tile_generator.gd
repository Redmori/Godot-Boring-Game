extends Node2D

@export var tracker : Node2D #use player as tracker

var old_position
var old_tile_position

#constants
var tile_size = 50
var tile_stack_height = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	old_position = tracker.global_position[0]
	old_tile_position = int(old_position / tile_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #TODO do this on a timer instead of every physics process frame
	if(tracker.global_position[0] > old_position):
		old_position = tracker.global_position[0]
		var new_tile_position = int(old_position / tile_size)
		if(new_tile_position > old_tile_position):
			print("generatedddd")
			generate_column(new_tile_position)
			old_tile_position = new_tile_position

func generate_column(index):
	for h in range(tile_stack_height):
		generate_tile(index, h)

func generate_tile(index, height):
	var new_tile = load("res://Scenes/block.tscn").instantiate()
	add_child((new_tile))
	new_tile.position[0] = index * tile_size
	new_tile.position[1] = -height * tile_size
