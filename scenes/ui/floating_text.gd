extends Node2D


func _ready():
	pass


func start(text: String):
	$Label.text = text

	var tween = create_tween()
	tween.set_parallel()

	tween.tween_property(self, "global_position", global_position + Vector2.UP * 16, 0.4)\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.chain()

	tween.tween_property(self, "global_position", global_position + Vector2.UP * 48, 0.3)\
			.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15).set_delay(0.15)\
			.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.chain()

	tween.tween_callback(queue_free)
