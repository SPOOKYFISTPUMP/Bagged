extends Node2D

func _input(event):
	if !Game.can_interact():
		return

	if event.is_action_pressed("ui_interact") && $InteractionArrow.player_in_sight:
		interact()

func interact():
	pass
