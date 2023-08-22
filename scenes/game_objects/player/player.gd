extends CharacterBody2D

const MAX_SPEED : int = 150
const ACCELERATION_SMOOTHING = 25

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar


var number_colliding_bodies = 0


func _ready():
	update_health_display()


func _process(delta):
	var direction = get_movement_vector().normalized()
	var target_velocity = direction * MAX_SPEED 
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector():
	var x_vector = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_vector = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_vector, y_vector)


func check_deal_damage():
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(number_colliding_bodies)
	damage_interval_timer.start()
	print(health_component.current_health)


func update_health_display():
	health_bar.value = health_component.get_health_percent()


func _on_collision_area_2d_body_entered(_body):
	number_colliding_bodies += 1
	check_deal_damage()


func _on_collision_area_2d_body_exited(_body):
	number_colliding_bodies -= 1


func _on_damage_interval_timer_timeout():
	check_deal_damage()


func _on_health_component_health_changed():
	update_health_display()
