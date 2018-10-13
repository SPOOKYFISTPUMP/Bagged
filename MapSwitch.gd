extends "res://Interactable.gd"

export(String, FILE) var map

func interact():
	assert(map)
	Game.switch_map(map)
