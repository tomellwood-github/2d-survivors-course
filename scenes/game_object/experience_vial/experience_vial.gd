extends Node2D

@onready var sprite = $Sprite2D


func _ready():
	$Area2D.area_entered.connect(on_area_entered, CONNECT_ONE_SHOT)


func tween_collect(percent: float, start_pos: Vector2):
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	global_position = start_pos.lerp(player.global_position, percent)

	# Rotate the vial towards the player
#	var dir_from_start = global_position - start_pos
#	rotation_degrees = rad_to_deg(dir_from_start.angle()) + 90


func collect():
	GameEvents.emit_experience_vial_collected(1)
	queue_free()


func on_area_entered(_other_area: Area2D):
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_method(tween_collect.bind(global_position), 0.0, 1.0, 0.5)\
			.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2.ZERO, 0.05).set_delay(0.45)
	tween.chain()
	tween.tween_callback(collect)
