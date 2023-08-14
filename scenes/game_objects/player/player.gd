extends CharacterBody2D

const MAX_SPEED : int = 150
const ACCELERATION_SMOOTHING = 25


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_movement_vector().normalized()
	var target_velocity = direction * MAX_SPEED 
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()

func get_movement_vector():
	var x_vector = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_vector = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_vector, y_vector)