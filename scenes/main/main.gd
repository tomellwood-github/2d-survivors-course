extends Node

@export var end_screen_scene: PackedScene

var pause_menu_screen = preload("res://scenes/ui/pause_menu.tscn")


func _ready():
	%Player.health_component.died.connect(on_player_died)


func _input(event):
	if event.is_action_pressed("pause"):
		add_child(pause_menu_screen.instantiate())


func on_player_died():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
