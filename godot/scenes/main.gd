extends Node2D

var points = 0

func _ready() -> void:
	$UI.update_points(points)

func _on_player_hp_changed(hp: Variant, max_hp: Variant) -> void:
	$UI.update_hp(hp, max_hp)

func _on_player_destroyed() -> void:
	$UI.game_over()

func _on_enemy_destroyed() -> void:
	points += 1
	$UI.update_points(points)

func _on_map_enemy_spawned(enemy: Variant) -> void:
	enemy.destroyed.connect(_on_enemy_destroyed)
