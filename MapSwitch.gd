extends "res://Interactable.gd"

export(String, FILE) var map

func interact():
	assert(map)
	get_tree().change_scene(map)