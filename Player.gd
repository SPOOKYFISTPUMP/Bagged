extends KinematicBody2D

const MOVEMENT_SPEED = 12

func _init():
	pass

func _process(delta):
	handle_movement(delta)

func handle_movement(delta):
	var input_vector = get_input_vector()

	if input_vector != Vector2():
		move_and_slide(
			input_vector.normalized() *
			MOVEMENT_SPEED * 1000 *
			delta
		)

func get_input_vector():
	var input_vector = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	
	return input_vector