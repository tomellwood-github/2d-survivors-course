class_name FireballAbility
extends Node2D

const MOVE_SPEED = 100

var direction = Vector2.ZERO
var lifespan = 1

@onready var hitbox_component: HitboxComponent = $HitboxComponent


func _ready():
	$VisibleOnScreenNotifier2D.screen_exited.connect(on_screen_exited)
	hitbox_component.area_entered.connect(on_body_entered)


func _process(delta):
	global_position += direction * delta * MOVE_SPEED


func destroy():
	queue_free()


func on_screen_exited():
	destroy()


func on_body_entered(body: Node2D):
	lifespan -= 1

	if lifespan <= 0:
		destroy()
