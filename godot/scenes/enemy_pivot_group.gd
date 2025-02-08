extends Node2D

signal enemy_spawned(enemy)

@export var enemy_to_spawn: PackedScene

func _on_spawn_timer_timeout() -> void:
	var e = enemy_to_spawn.instantiate()
	e.initial_distance = 400
	e.angle = randf_range(0, 2*PI)
	call_deferred("add_child", e)
	enemy_spawned.emit(e)
