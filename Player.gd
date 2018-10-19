extends KinematicBody2D

const MOVEMENT_SPEED = 10
var initial_x_scale

onready var sprite = get_node("Position2D")

func _ready():
	initial_x_scale = sprite.scale.x

func _process(delta):
	handle_movement(delta)

func handle_movement(delta):
	var input_vector = get_input_vector()

	if input_vector != Vector2():
		if input_vector.x:
			flip(input_vector.x)

		move_and_slide(
			input_vector.normalized() *
			MOVEMENT_SPEED * 1000 *
			delta
		)

		if $AnimationPlayer.current_animation != "Walk":
			$AnimationPlayer.play("Walk")
	else:
		if $AnimationPlayer.current_animation != "RESET":
			$AnimationPlayer.play("RESET")

func get_input_vector():
	var input_vector = Vector2()

	if !Game.can_move():
		return input_vector

	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	
	return input_vector

func flip(x):
	var factor = sign(x)

	if sprite.scale.x == factor * initial_x_scale || $Tween.is_active():
		return

	$Tween.interpolate_property(sprite, "scale:x", sprite.scale.x, initial_x_scale * factor, .1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
