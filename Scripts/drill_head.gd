extends Area2D

@export var inventory : Node2D
@onready var ray_cast_2d = $RayCast2D

@export var mining_speed = 2
@onready var drill_distance = ray_cast_2d.target_position.x

var progress = 0
var max_health = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#drill(delta)
	pass

func drill(delta):
	if ray_cast_2d.is_colliding():
			if progress <= 0:
				var tile_map = ray_cast_2d.get_collider()  #TODO: is there a better way to get the tile_map in each drillhead?
				var new_health = tile_map.get_tile_health(ray_cast_2d.global_position + ray_cast_2d.target_position)
				if new_health > 0:
					progress = new_health
					max_health = new_health
			else:
				progress -= delta*mining_speed
				if progress <= 0:
					var tile_map = ray_cast_2d.get_collider()  #TODO: is there a better way to get the tile_map in each drillhead?
					tile_map.mine_tile(ray_cast_2d.global_position + ray_cast_2d.target_position)
					if inventory:
						inventory.add_item(1)
			var origin = ray_cast_2d.global_position
			var collision_point = ray_cast_2d.get_collision_point()
			#var normalized_distance = origin.distance_to(collision_point) / drill_distance
			#print(origin.distance_to(collision_point) , " ", progress , " " , max_health)
			var distance = (1-progress/max_health)*25 - (ray_cast_2d.target_position.x - origin.distance_to(collision_point))
			return distance
	return 50
#not needed anymore?
func _on_body_entered(body):
	#body.queue_free()
	#inventory.add_item(1)
	#print("add item")
	pass
