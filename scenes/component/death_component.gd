extends Node2D

@export var health_component: HealthComponent
@export var sprite: Sprite2D

@onready var animation_player = $AnimationPlayer


func _ready() -> void:
	$GPUParticles2D.texture = sprite.texture
	health_component.died.connect(on_died)


func on_died():
	if owner == null or not owner is Node2D:
		return

	var spawn_pos = owner.global_position
	var entities = get_tree().get_first_node_in_group("entities_layer")
	get_parent().remove_child(self)
	entities.add_child(self)
	global_position = spawn_pos
	animation_player.play("default")
