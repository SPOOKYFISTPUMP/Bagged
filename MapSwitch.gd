extends "res://Interactable.gd"

export(String, FILE) var map

var obstacle_blocking = false

func _ready():
	$InteractionArrow.visible = true

func interact():
	if obstacle_blocking:
		return

	assert(map)
	Game.switch_map(map)

func _on_Area2D_body_entered(body):
	if body.get_parent().is_in_group("Obstacle"):
		$InteractionArrow.visible = false
		obstacle_blocking = true

func _on_Area2D_body_exited(body):
	if body.get_parent().is_in_group("Obstacle"):
		$InteractionArrow.visible = true
		obstacle_blocking = false
