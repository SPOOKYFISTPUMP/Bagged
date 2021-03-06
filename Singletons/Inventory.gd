extends Node

var space = []
var quantities = {}

var mysterious_item = preload("res://Items/Mysterious Item.tres")

onready var item_list = $CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/ItemList
onready var panel = $CenterContainer/Panel

func _ready():
	add_item(mysterious_item)

func _input(event):
	if Game.can_interact() && event.is_action_pressed("ui_inventory"):
		$CenterContainer/Panel.visible = true
		Game.state = Game.States.Inventory

func add_item(item, quantity = 1):
	assert(quantity >= 1)

	if space.has(item):
		assert(item.stackable)
		quantities[item] += quantity
	else:
		space.push_back(item)
		quantities[item] = quantity

	display_inventory()

func remove_item(item, quantity = 1):
	assert(quantity >= 1)

	if !space.has(item):
		return false

	if !item.consumable:
		return true

	assert(quantities.has(item))

	if quantities[item] < quantity:
		return false
	
	quantities[item] -= quantity

	if quantities[item] == 0:
		space.erase(item)
		quantities.erase(item)

	display_inventory()
	return true


func display_inventory():
	item_list.clear()

	for item in space:
		assert(quantities[item])
		var quantity = quantities[item]
		var text

		var plural = quantity > 1
	
		if plural:
			text = str(quantity) + "x " + item.title + "s"
		else:
			text = item.title

		item_list.add_item(text, item.image)

func _on_Close_pressed():
	if !Game.state == Game.States.Inventory:
		return

	panel.visible = false
	Game.state = Game.States.Explore

func _on_Inspect_pressed():
	if !Game.state == Game.States.Inventory:
		return

	var selected = item_list.get_selected_items()
	var index

	if selected.size():
		index = selected[0]
	else:
		return

	DialogueBox.dialogue_queue.push_back({
		"who": space[index].title,
		"says": space[index].description,
	})

	panel.visible = false
	yield(DialogueBox, "closed")
	panel.visible = true
