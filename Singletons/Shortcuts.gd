extends Node

func _input(event):
	if event.is_action_pressed("ui_escape"):
		get_tree().quit()
	if event.is_action_pressed("ui_reload"):
		get_tree().change_scene("res://Main.tscn")
