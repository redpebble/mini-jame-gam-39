extends Node2D

signal player_ready(player)
signal enemy_spawned(enemy)

func _ready() -> void:
	player_ready.emit($Player)

func _on_enemy_spawner_enemy_spawned(enemy: Variant) -> void:
	enemy_spawned.emit(enemy)
