extends Node

signal item_added

var space = []
var quantities = {}

func add_item(item, quantity = 1):
	assert(quantity >= 1)

	if space.has(item):
		assert(item.stackable)
		quantities[item] += quantity
	else:
		space.push_back(item)
		quantities[item] = quantity

	emit_signal("item_added")