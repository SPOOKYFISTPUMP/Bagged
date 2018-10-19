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
	OS.set_window_maximized(true)

	if _node("Player"):
		state = Explore
		intro()

func _node(string):
	return get_tree().current_scene.get_node(string)

func set_state(new_state):
	state = new_state

func intro():
	state = Cutscene

	var player = _node("Player")

	yield(get_tree().create_timer(1), "timeout")
	player.flip(-1)
	yield(get_tree().create_timer(.3), "timeout")
	player.flip(1)
	yield(get_tree().create_timer(.5), "timeout")

	DialogueBox.dialogue_queue.push_back({
		"who": "You",
		"says": "Where am I?"
	})

	yield(DialogueBox, "closed")
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
			_node("Player").position = mapswitch_node.position + Vector2(0, 32)

func consumed(node):
	assert(!was_consumed(node))

	add_flag(node.get_path())

func was_consumed(node):
	return has_flag(node.get_path())

func add_flag(flag):
	return flags.push_back(flag)

func has_flag(flag):
	return flags.has(flag)

func can_act():
	return [Explore, AutomaticDialogue].has(state)

func can_move():
	return can_act()

func can_interact():
	return can_act()

func button_press():
	var doors = get_tree().get_nodes_in_group("Door")

	print("??")

	for door in doors:
		var door_path = str(door.get_path())

		print(door_path)

		if !Database.door_logic.has(door_path):
			continue

		var buttons = Database.door_logic[door_path]
		var valid = true

		for button_path in buttons:
			if get_node(button_path).pressed != buttons[button_path]:
				valid = false
		
		if valid:
			assert(_node("Camera"))
			assert(_node("Player"))

			state = States.Cutscene

			yield(get_tree().create_timer(.5), "timeout")
			_node("Camera").follow_node = door
			yield(get_tree().create_timer(.5), "timeout")
			door.open()
			yield(get_tree().create_timer(.5), "timeout")

			_node("Camera").follow_node = _node("Player")
			state = States.Explore
		else:
			door.close()
