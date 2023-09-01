extends CharacterBody2D

var is_moving = false

@onready var velocity_component = $VelocityComponent
@onready var visuals = $Visuals


func _process(_delta):
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()

	velocity_component.move(self)

	visuals.scale.x = sign(velocity.x)


func set_is_moving(moving: bool):
	is_moving = moving
