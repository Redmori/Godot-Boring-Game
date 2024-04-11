extends Node2D

var machine_connected = false

func _input(event : InputEvent):
	if(event.is_action_pressed("hotkey_2") and !machine_connected and false): #NOT USED ANYMORE
		var new_machine = load("res://machine.tscn").instantiate()
		%stack_point.add_child(new_machine)
		machine_connected = true
		
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if Input.is_action_just_pressed("hotkey_2") and !machine_connected:
		#var new_machine = load("res://machine.tscn").instantiate()
		#%stack_point.add_child(new_machine)
		#machine_connected = true
