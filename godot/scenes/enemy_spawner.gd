extends Node2D

signal enemy_spawned(enemy)

@export var enemies_per_ring: int = 12
@export var enemy_to_spawn: PackedScene
@export var speed: float = 3
@export var initial_distance: float = 700

func _ready() -> void:
	var interval = 2*PI/enemies_per_ring
	for i in enemies_per_ring:
		var e = enemy_to_spawn.instantiate()
		e.initial_distance = initial_distance
		e.initial_angle = i * interval
		e.ready.connect(func(): enemy_spawned.emit(e))
		call_deferred("add_child", e)

func _physics_process(delta: float) -> void:
	rotate(speed * delta)
