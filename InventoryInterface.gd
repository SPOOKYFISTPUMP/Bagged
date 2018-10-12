extends CanvasLayer

var label = preload("res://DefaultLabel.tscn")

func _ready():
	handle_labels()
	Inventory.connect("item_added", self, "_on_item_added")

func _on_item_added():
	handle_labels()

func handle_labels():
	var labels = $MarginContainer/VBoxContainer.get_children()

	# delete all the labels
	for label in labels:
		label.queue_free()

	print(Inventory.space)

	# add all the labels
	for item in Inventory.space:
		var new_label = label.instance()
		var quantity = Inventory.quantities[item]
		var plural = quantity > 1
		new_label.text = str(quantity) + "x " + item.title + ("s" if plural else "")
		$MarginContainer/VBoxContainer.add_child(new_label)
		print("Sidn driN!")