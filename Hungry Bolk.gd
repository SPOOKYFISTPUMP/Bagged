extends "res://Interactable.gd"

const FIRST_TALK = "First Talk with Bolko"
const GAVE_APPLE = "Gave Bolko Apple"

var apple = preload("res://Apple.tres")
var happy_sprite = preload("res://bolk-happy.png")

var talking = false
var player

func _ready():
	if Game._node("Player"):
		player = Game._node("Player")

	if Game.has_flag(GAVE_APPLE):
		$Sprite.texture = happy_sprite

func interact():
	if Game.has_flag(FIRST_TALK):
		var callback = Inventory.remove_item(apple, 1)
	
		if callback:
			gave_bolko_apple()

func _physics_process(delta):
	if talking:
		return

	if player:
		var flip = player.position.x - position.x < 0

		if Game.has_flag(FIRST_TALK):
			flip = !flip

		$Sprite.flip_h = flip

func _on_InteractionArrow_player_sighted(entered):
	if Game.has_flag(FIRST_TALK) && !Game.has_flag(GAVE_APPLE):
		$AppleLabel.visible = entered
		$InteractionArrow.visible = entered

	if !entered || Game.has_flag(FIRST_TALK):
		return

	first_talk_with_bolko()

func first_talk_with_bolko():
	Game.add_flag("First Talk with Bolko")
	talking = true

	Game.state = Game.States.Cutscene

	DialogueBox.dialogue_queue.push_back({
		"who": "???",
		"says": "*murmur*"
	})

	yield(DialogueBox, "closed")
	yield(get_tree().create_timer(.3), "timeout")

	DialogueBox.dialogue_queue.push_back({
		"who": "???",
		"says": "...!",
		"speed": 2
	})

	yield(DialogueBox, "closed")

	$Sprite.flip_h = !$Sprite.flip_h
	yield(get_tree().create_timer(.3), "timeout")

	$AnimationPlayer.play("Scare")
	$AnimationPlayer.queue("RESET")

	DialogueBox.dialogue_queue.push_back({
		"who": "???",
		"says": "AHH!",
		"speed": .1
	})

	yield(DialogueBox, "closed")
	yield(get_tree().create_timer(1), "timeout")

	DialogueBox.dialogue_queue.push_back({
		"who": "???",
		"says": "I'm sorry, I'm not used seeing people here.",
	})

	yield(DialogueBox, "closed")

	DialogueBox.dialogue_queue.push_back({
		"who": "Bolko",
		"says": "I'm Bolko, nice to meet you. Do you have some food?",
	})

	yield(DialogueBox, "closed")

	talking = false
	Game.state = Game.States.Explore

func gave_bolko_apple():
	Game.add_flag(GAVE_APPLE)
	$AppleLabel.visible = false
	$InteractionArrow.visible = false

	DialogueBox.dialogue_queue.push_back({
		"who": "Bolko",
		"says": "*NOMNOMNOM*",
		"speed": 1
	})

	$AnimationPlayer.play("nomnom")
	$AnimationPlayer.queue("RESET")

	yield(DialogueBox, "closed")

	$Sprite.texture = happy_sprite

	DialogueBox.dialogue_queue.push_back({
		"who": "Bolko",
		"says": "Thank you so much!",
	})

	yield(DialogueBox, "closed")
