extends Node

signal arena_difficulty_increased(arena_difficulty: int)

@export var end_screen_scene: PackedScene

var arena_difficulty = 0

@onready var timer = $Timer
@onready var difficulty_interval_timer = $DifficultyIntervalTimer


func _ready():
	timer.timeout.connect(on_timer_timeout)
	difficulty_interval_timer.timeout.connect(on_difficulty_interval_timer_timeout)


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func on_difficulty_interval_timer_timeout():
	arena_difficulty += 1
	arena_difficulty_increased.emit(arena_difficulty)


func on_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.play_jingle()
	MetaProgression.save()
