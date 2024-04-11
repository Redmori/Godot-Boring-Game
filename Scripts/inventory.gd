extends Node2D

@export var item_scene : PackedScene
@export var drop_off_point : Area2D

@export var items = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	drop_item()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func drop_item():
	if items > 0:
		var new_item = item_scene.instantiate()
		drop_off_point.call_deferred("add_child",new_item)
		#drop_off_point.add_child(new_item)
		items -= 1

func add_item(n):
	items += n
	if drop_off_point.get_overlapping_bodies().size() == 0:
		drop_item()

func _on_drop_off_body_exited(body):
	drop_item()
