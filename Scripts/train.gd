extends CharacterBody2D

@onready var ray_cast_2d = $RayCast2D

var speed = 0

var drills : Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#velocity = Vector2(1,0)*delta*speed
	#move_and_slide() 
	
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		##if collision.get_collider() is Player:
		#collision.get_collider().move_and_collide(velocity)
	if not ray_cast_2d.is_colliding():
		var distance = delta*speed
		for drill in drills:
			var d = drill.drill(delta)
			if d < distance:
				distance = d
		if distance >= 0:
			position.x += distance

func _input(event : InputEvent):
	if(event.is_action_pressed("ui_focus_next")):
		speed *= 1.1
		speed += 10
		
func add_drill(new_drill):
	drills.append(new_drill.get_node("DrillHead"))

