extends Area2D


var mouse_hover = false
var in_range = false
var blocked = false
@export var spot_type = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass #spot_type = randi_range(1,2) #TEMP random building slot type to test


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():	
	mouse_hover = true
	if(in_range and not blocked):
		%indicator.visible = true

func _on_mouse_exited():
	%indicator.visible = false
	mouse_hover = false

func range_enter():	
	in_range = true
	if(mouse_hover):
		%indicator.visible = true

func range_leave():
	in_range = false
	%indicator.visible = false

func occupy():
	#monitorable = false
	set_deferred("monitorable", false) 
	#monitoring = false #why do i have to do this? is this a bug in godot? turning off monitoring in the inspector doesnt do the same
	set_deferred("monitoring", false) 
	blocked = true
