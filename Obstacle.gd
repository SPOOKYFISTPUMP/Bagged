extends "res://Interactable.gd"

export(Resource) var needed_item
export(int) var needed_item_amount

func _ready():
	if Game.was_consumed(self):
		consumed()

	assert(needed_item)
	assert(needed_item_amount >= 1)

	$InteractionArrow.visible = true
	$DefaultLabel.visible = false
	$DefaultLabel.set_label(needed_item.title, needed_item_amount, " needed")

func interact():
	var callback = Inventory.remove_item(needed_item, needed_item_amount)
	
	if callback:
		Game.consumed(self)
		consumed()

func consumed():
	# später noch den spawn einbauen
	queue_free()

func _on_InteractionArrow_player_sighted(entered):
	$DefaultLabel.visible = entered
