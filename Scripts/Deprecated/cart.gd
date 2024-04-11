extends Node2D

#var cart_connected = false
#var machine_1_connected = false
#var machine_2_connected = false

func _ready():
	#%spot_cart.spot_type = 1
	#%spot_machine_1.spot_type = 2
	#%spot_machine_2.spot_type = 2
	pass



#func _input(event : InputEvent):
	#if(event.is_action_pressed("hotkey_1") and !cart_connected):
		#var new_cart = load("res://cart.tscn").instantiate()
		#%connection_point.add_child(new_cart)
		#cart_connected = true
	#elif(event.is_action_pressed("hotkey_2") and false): #NOT USED ANYMORE
		#if(!machine_1_connected):
			#var new_machine = load("res://machine.tscn").instantiate()
			#%stack_point_1.add_child(new_machine)
			#machine_1_connected = true
		#elif(!machine_2_connected):
			#var new_machine = load("res://machine.tscn").instantiate()
			#%stack_point_2.add_child(new_machine)
			#machine_2_connected = true

#func _process(delta):
	#if Input.is_action_just_pressed("hotkey_1") and !cart_connected:
		#var new_cart = load("res://cart.tscn").instantiate()
		#%connection_point.add_child(new_cart)
		#cart_connected = true
		#
	#if Input.is_action_just_pressed("hotkey_2") and !machine_1_connected:
		#var new_machine = load("res://machine.tscn").instantiate()
		#%stack_point_1.add_child(new_machine)
		#machine_1_connected = true
	#elif Input.is_action_just_pressed("hotkey_2") and !machine_2_connected:		
		#var new_machine = load("res://machine.tscn").instantiate()
		#%stack_point_2.add_child(new_machine)
		#machine_1_connected = true
