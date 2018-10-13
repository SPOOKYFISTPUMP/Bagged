extends "res://Interactable.gd"

export(Array, Dictionary) var things_to_say

func _ready():
	$InteractionArrow.visible = true

func interact():
	print(things_to_say)
	for dialogue in things_to_say:
		DialogueBox.dialogue_queue.push_back({
			"who": dialogue.who,
			"says": dialogue.says
		})
