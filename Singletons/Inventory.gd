extends Node

signal inventory_changed

var space = []
var quantities = {}

var mysterious_item = preload("res://Items/Mysterious Item.tres")

func _ready():
	add_item(mysterious_item)

func add_item(item, quantity = 1):
	assert(quantity >= 1)

	if space.has(item):
		assert(item.stackable)
		quantities[item] += quantity
	else:
		space.push_back(item)
		quantities[item] = quantity

	emit_signal("inventory_changed")

func remove_item(item, quantity = 1):
	assert(quantity >= 1)

	if !space.has(item):
		return false

	assert(quantities.has(item))

	if quantities[item] < quantity:
		return false
	
	quantities[item] -= quantity

	if quantities[item] == 0:
		space.erase(item)
		quantities.erase(item)

	emit_signal("inventory_changed")
	return true
