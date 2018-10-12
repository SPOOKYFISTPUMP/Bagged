extends Node2D

export(Resource) var item

func _ready():
	assert(item)
	$Sprite.texture = item.image

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		Inventory.add_item(item)
		queue_free()
