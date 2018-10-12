extends "res://Interactable.gd"

export(PackedScene) var map

func interact():
	assert(map)
	get_tree().change_scene_to(map)