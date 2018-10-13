extends Node

enum States {
	NONE # this shouldn't be boy
	Cutscene
	Inventory
	Explore # Walking around, interacting and stuff
	Dialogue # Talking to someone
	AutomaticDialogue # e.g. "You cut the wire", you can move during that
}
var state = NONE setget set_state

var flags = []
var map_before

func _ready():
	if _node("Player"):
		state = Explore
		# intro()

func _node(string):
	return get_tree().current_scene.get_node(string)

func set_state(new_state):
	state = new_state

func intro():
	state = Cutscene

	var player = _node("Player")

	yield(get_tree().create_timer(1), "timeout")
	player.flip(-1)
	yield(get_tree().create_timer(.5), "timeout")
	player.flip(1)
	yield(get_tree().create_timer(.5), "timeout")
	player.flip(-1)
	yield(get_tree().create_timer(.5), "timeout")

	DialogueBox.dialogue_queue.push_back({
		"who": "MaxMustermann",
		"says": "Where am I?"
	})

func switch_map(map):
	map_before = get_tree().current_scene.filename
	get_tree().change_scene(map)

	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	var mapswitch_nodes = get_tree().get_nodes_in_group("MapSwitch")

	for mapswitch_node in mapswitch_nodes:
		if mapswitch_node.map == map_before:
			_node("Player").position = mapswitch_node.position + Vector2(0, 32)

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
