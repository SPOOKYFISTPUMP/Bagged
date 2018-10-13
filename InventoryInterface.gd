extends CanvasLayer

var label = preload("res://DefaultLabel.tscn")

func _ready():
	handle_labels()
	Inventory.connect("inventory_changed", self, "_on_inventory_changed")

func _on_inventory_changed():
	handle_labels()

func handle_labels():
	var labels = $MarginContainer/VBoxContainer.get_children()

	# delete all the labels
	for label in labels:
		label.queue_free()

	# add all the labels
	for item in Inventory.space:
		var new_label = label.instance()
		var quantity = Inventory.quantities[item]
		new_label.set_label(item.title, quantity)

		$MarginContainer/VBoxContainer.add_child(new_label)
