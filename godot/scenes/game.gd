extends Node2D

signal player_ready(player)
signal enemy_spawned(enemy)

func _ready() -> void:
	player_ready.emit($PlayerPivot/Player)

func _on_enemy_pivot_group_enemy_spawned(enemy: Variant) -> void:
	enemy_spawned.emit(enemy)
