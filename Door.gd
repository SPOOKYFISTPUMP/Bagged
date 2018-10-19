extends Node2D

export(bool) var open = false
export(bool) var zoomed = false

func _ready():
	handle_sprite()

func handle_sprite():
	$Sprite.region_rect.position.x = 32 if open else 0
	$StaticBody2D/CollisionShape2D.disabled = open

func open():
	open = true
	handle_sprite()

func close():
	open = false
	handle_sprite()
