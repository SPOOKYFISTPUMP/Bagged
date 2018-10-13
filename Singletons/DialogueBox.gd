extends CanvasLayer

export(Array) var dialogue_queue = []
var dialogue_done = true

func _ready():
	dialogue_queue.push_back({
		"who": "OK",
		"says": "nice",
		"speed": 3
	})
	dialogue_queue.push_back({
		"who": "OK",
		"says": "nice even nicer",
		"speed": .1
	})

func _process(delta):
	if !$Panel.visible && dialogue_queue.size():
		var dialogue = dialogue_queue.pop_front()
		play_dialogue(dialogue)

func _input(event):
	if dialogue_done && event.is_action_pressed("ui_interact"):
		end_dialogue()

func play_dialogue(dialogue):
	Game.state = Game.States.Dialogue

	dialogue_done = false
	$Panel.visible = true
	$Panel/CenterContainer/DialogueArrow.visible = false

	var who_label = $Panel/MarginContainer/VBoxContainer/Who
	var says_label = $Panel/MarginContainer/VBoxContainer/Says

	who_label.text = dialogue.who + ":"
	says_label.text = dialogue.says

	var speed = dialogue.speed if dialogue.has("speed") else 1

	$Tween.interpolate_property(says_label, "percent_visible", 0, 1, speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	dialogue_done = true
	$Panel/CenterContainer/DialogueArrow.visible = true

func end_dialogue():
	Game.state = Game.States.Explore
	$Panel.visible = false
