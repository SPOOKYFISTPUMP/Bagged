extends "res://Interactable.gd"

export(Resource) var needed_item
export(int) var needed_item_amount

func interact():
	var callback = Inventory.remove_item(needed_item, needed_item_amount)
	
	if callback:
		queue_free()
