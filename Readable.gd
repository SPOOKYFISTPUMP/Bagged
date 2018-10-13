extends "res://Interactable.gd"

func _ready():
	$InteractionArrow.visible = true

func interact():
	DialogueBox.read_my_text(self)
