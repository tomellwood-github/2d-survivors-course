extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []

var meta_upgrade_card_scene = preload("res://scenes/ui/meta_upgrade_card.tscn")

@onready var grid_container = %GridContainer
@onready var back_button = %BackButton


func _ready():
	back_button.pressed.connect(on_back_pressed)
	# Remove children used for testing UI
	for child in grid_container.get_children():
		child.queue_free()

#
	for upgrade in upgrades:
		var meta_upgrade_card_instance = meta_upgrade_card_scene.instantiate()
		grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)


func on_back_pressed():
	ScreenTransition.transition_to_scene("res://scenes/ui/main_menu.tscn")
