extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#%spot_axle_left.spot_type = 3
	#%spot_axle_right.spot_type = 3
	#%spot_cog_top.spot_type = 4
	#%spot_cog_bot.spot_type = 4
	var parent = get_parent().name
	
	if parent == "spot_axle_left":
		%spot_axle_right.occupy()
	if parent == "spot_axle_right":
		%spot_axle_left.occupy()
	if parent == "spot_cog_top":
		%spot_cog_bot.occupy()
	if parent == "spot_cog_bot":
		%spot_cog_top.occupy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
