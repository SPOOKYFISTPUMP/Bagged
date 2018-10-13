extends "res://Interactable.gd"

export(bool) var pressed = false

func _ready():
	handle_sprite()
	$InteractionArrow.visible = true

func handle_sprite():
	$Sprite.region_rect.position.x = 16 if pressed else 0

func interact():
	pressed = !pressed
	handle_sprite()
	Game.button_press()
