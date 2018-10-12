extends Node2D

func _input(event):
	if event.is_action_pressed("ui_interact") && $InteractionArrow.player_in_sight:
		interact()

func interact():
	pass
