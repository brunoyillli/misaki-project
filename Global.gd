extends Node


var points = 0

# Called when the node enters the scene tree for the first time.
func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
