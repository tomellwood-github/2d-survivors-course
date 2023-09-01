extends CharacterBody2D

@onready var velocity_component = $VelocityComponent
@onready var visuals = $Visuals


func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	visuals.scale.x = -sign(velocity.x)
