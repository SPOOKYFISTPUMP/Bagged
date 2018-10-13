extends Camera2D

const FOLLOW_NODE_GROUP = "Player"

var follow_node

func _ready():
	var nodes_in_group = get_tree().get_nodes_in_group(FOLLOW_NODE_GROUP)
	
	if nodes_in_group.size():
		follow_node = nodes_in_group.pop_back()

func _process(delta):
	position = follow_node.position
