extends Node
class_name HealthComponent

signal died

@export var max_health : float = 10
var current_health


func _ready():
	current_health = max_health

# Function that damages the enemy and kills it
func damage(damage_amount: float):
	# Decrease the health tell it reach 0
	current_health = max(current_health - damage_amount, 0)
	# Kill the enemy if health is 0
	Callable(check_death).call_deferred()

# Function that kills the enemy if it's health reached 0
func check_death():
	if current_health == 0 :
		died.emit()
		owner.queue_free()