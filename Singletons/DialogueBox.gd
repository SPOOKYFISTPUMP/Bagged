extends CanvasLayer

signal closed

export(Array) var dialogue_queue = []
var dialogue_done = true

var state_before

onready var who_label = $Panel/MarginContainer/VBoxContainer/Who
onready var says_label = $Panel/MarginContainer/VBoxContainer/Says

func _ready():
	pass

func _process(delta):
	if !$Panel.visible && dialogue_queue.size():
		var dialogue = dialogue_queue.pop_front()
		play_dialogue(dialogue)

func _input(event):
	if Game.state != Game.States.Dialogue:
		return

	if !dialogue_done:
		return

	if event.is_action_pressed("ui_interact") || event.is_action_pressed("ui_accept"):
		end_dialogue()

func read_my_text(node):
	var key = str(node.get_path())

	assert(Database.dialogues.has(key))

	for dialogue in Database.dialogues[key]:
		dialogue_queue.push_back(dialogue)

func play_dialogue(dialogue):
	state_before = Game.state
	Game.state = Game.States.Dialogue

	dialogue_done = false
	$Panel.visible = true
	$Panel/CenterContainer/DialogueArrow.visible = false

	if !dialogue.has("who") || dialogue.who == "":
		who_label.visible = false
		says_label.max_lines_visible = 3
	else:
		who_label.visible = true
		says_label.max_lines_visible = 2

	if dialogue.has("who"):
		who_label.text = dialogue.who + ":"

	says_label.text = dialogue.says

	var speed = dialogue.speed if dialogue.has("speed") else 1

	$Tween.interpolate_property(says_label, "percent_visible", 0, 1, speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_Tween_tween_completed(object = null, key = null):
	dialogue_done = true
	$Panel/CenterContainer/DialogueArrow.visible = true

func end_dialogue():
	if state_before == Game.States.Cutscene:
		Game.state = Game.States.Explore
	else:
		Game.state = state_before

	says_label.percent_visible = 0
	$Panel.visible = false

	emit_signal("closed")
