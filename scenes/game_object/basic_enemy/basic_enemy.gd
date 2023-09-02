extends CharacterBody2D

@onready var velocity_component = $VelocityComponent
@onready var visuals = $Visuals


func _ready():
	$HurtboxComponent.hit.connect(on_hit)


func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	visuals.scale.x = -sign(velocity.x)


func on_hit():
	$HitRandomAudioPlayerComponent.play_random()
