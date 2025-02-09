class_name Gun extends Node2D

signal reloaded

@export var reload_time: float = 1
@export var speed: int = 1000
@export var projectile: PackedScene
@export var is_enemy_weapon: bool = false
var loaded = true

func fire(direction: Vector2):
	if loaded:
		var p = projectile.instantiate()
		p.init(direction, speed, global_transform, is_enemy_weapon)
		get_tree().get_root().call_deferred("add_child", p)
		loaded = false
		$ReloadTimer.start()

func _on_reload_timer_timeout() -> void:
	loaded = true
	reloaded.emit()

func _ready() -> void:
	$ReloadTimer.wait_time = reload_time
