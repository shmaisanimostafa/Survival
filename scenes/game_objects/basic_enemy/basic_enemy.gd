extends CharacterBody2D

@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	# Make the enemy look to the moving direction ( to the player )
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)
