extends Node2D




func _process(_delta):
	if get_global_position().y <= 700:
		position.y += 0.495
		
	else: 
		position.y = -100
		position.x = rand_range(0,600)
