extends Node

enum States {
	NONE # this shouldn't be boy
	Explore # Walking around, interacting and stuff
	Dialogue # Talking to someone
	AutomaticDialogue # e.g. "You cut the wire", you can move during that
}
var state = NONE

var flags = []
var map_before

func _ready():
	if get_tree().current_scene.get_node("Player"):
		state = Explore

func switch_map(map):
	map_before = get_tree().current_scene.filename
	get_tree().change_scene(map)

	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	var mapswitch_nodes = get_tree().get_nodes_in_group("MapSwitch")

	for mapswitch_node in mapswitch_nodes:
		if mapswitch_node.map == map_before:
			get_tree().current_scene.get_node("Player").position = mapswitch_node.position + Vector2(0, 32)

func consumed(node):
	assert(!was_consumed(node))

	flags.push_back(node.get_path())

func was_consumed(node):
	return flags.has(node.get_path())

func can_act():
	return [Explore, AutomaticDialogue].has(state)

func can_move():
	return can_act()

func can_interact():
	return can_act()
