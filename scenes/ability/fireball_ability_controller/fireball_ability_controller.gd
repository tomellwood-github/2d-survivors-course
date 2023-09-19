extends Node

const MAX_RANGE = 300

@export var fireball_ability: PackedScene

var base_damage = 10
var additional_damage_percent = 1
var base_wait_time
var lifespan = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D

	if player == null:
		return

	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)

	if enemies.size() == 0:
		return

	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)

	var fireball_instance = fireball_ability.instantiate() as FireballAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(fireball_instance)
	fireball_instance.hitbox_component.damage = base_damage * additional_damage_percent

	fireball_instance.global_position = player.global_position

	var enemy_direction = enemies[0].global_position - fireball_instance.global_position
	fireball_instance.rotation = enemy_direction.angle() + deg_to_rad(90)
	fireball_instance.direction = enemy_direction.normalized()
	fireball_instance.lifespan = lifespan


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	pass
	if upgrade.id == "fireball_rate":
		var percent_reduction = current_upgrades["fireball_rate"]["quantity"] * 0.1
		$Timer.wait_time = base_wait_time * (1 - percent_reduction)
		$Timer.start()
	elif upgrade.id == "fireball_lifespan":
		lifespan = 1 + current_upgrades["fireball_lifespan"]["quantity"]

