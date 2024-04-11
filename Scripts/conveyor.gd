extends Area2D

@export var items : Array[AnimatableBody2D]

@export var speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #TODO is doing this in process instead of physics bad?
	if items.size() > 0:
		for item in items:
			if item.position.y != 0:
				item.position.y = 0
			if item.position.x > -25:
				var collision = item.move_and_collide(Vector2(speed*delta*-1,0),true)#item.test_move(item.global_transform, Vector2(speed*delta*-2, 0))
				if not collision:
					item.position.x -= speed*delta #
				#item.move_and_collide(Vector2(speed*delta*-1,0),false,0) # items.position.x -= speed*delta


#func _on_area_entered(area):
	#print("items found")
	#area.call_deferred("reparent",self,true)
	#items.append(area)

func _on_child_exiting_tree(node):
	if items.has(node):
		items.erase(node)


func _on_body_entered(body):
	if not items.has(body) and not items.size() > 4:
		body.call_deferred("reparent",self,true)
		items.append(body)
