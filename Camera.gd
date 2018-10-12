extends Camera2D

var follow_node

func _ready():
	var player_node = get_tree().get_nodes_in_group("Player")
	
	if player_node.size():
		follow_node = player_node.pop_back()

func _process(delta):
	position = follow_node.position