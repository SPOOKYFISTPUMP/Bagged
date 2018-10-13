extends Node

var flags = []

func get_node_slug(node):
	return node.get_owner().get_name() + "/" + node.get_name()

func consumed(node):
	assert(!was_consumed(node))

	flags.push_back(get_node_slug(node))

func was_consumed(node):
	return flags.has(get_node_slug(node))
