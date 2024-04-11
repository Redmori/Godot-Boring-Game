extends TileMap

@export var tracker : Node2D #use player as tracker
@export var height = 10
@export var generation_distance = 20

var old_position
var old_tile_position

# Called when the node enters the scene tree for the first time.
func _ready():
	old_position = tracker.global_position[0]
	old_tile_position = local_to_map(tracker.global_position)[0]
	print(tracker.global_position, local_to_map(tracker.global_position))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(tracker.global_position[0] > old_position):
		old_position = tracker.global_position[0]
		var new_tile_position = local_to_map(to_local(tracker.global_position))[0]
		if(new_tile_position > old_tile_position):
			generate_column(new_tile_position+generation_distance)
			old_tile_position = new_tile_position
			
	## Mine with mouse-over:
	mine_tile(get_local_mouse_position())
			
func generate_column(x):
	for y in range(-1, -height, -1):
		set_cell(0,Vector2i(x,y),0,Vector2i(randi_range(2,5),0))
	set_cell(0,Vector2i(x,0),0,Vector2i(1,0))
	set_cell(0,Vector2i(x,-height),0,Vector2i(1,0))

func get_tile_health(local_position):
	var tile = local_to_map(local_position)
	var tile_data = get_cell_tile_data(0,tile)
	return tile_data.get_custom_data("type")
	

func mine_tile(local_position):
	var tile = local_to_map(local_position)
	var tile_data = get_cell_tile_data(0,tile)
	if tile_data and tile_data.get_custom_data("type") != -1:
		set_cell(0,tile,0, Vector2i(0,0))

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		mine_tile(get_local_mouse_position())
			#tile_data.set_custom_data("type", health - 1)
			#if health < 1:
				#set_cell(0,tile,0, Vector2i(1,0))
			#else:					
				#tile_data.set_custom_data("type", health - 1)
