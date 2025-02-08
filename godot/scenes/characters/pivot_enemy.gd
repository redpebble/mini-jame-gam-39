extends Node2D

@export var speed: float = 50
var initial_distance: float = 400
var angle: float = 0

func _ready() -> void:
	$Enemy.position.x = initial_distance
	$Enemy.rotation -= PI/2
	rotation = angle + PI/2

func _physics_process(delta: float) -> void:
	$Enemy.position.x -= delta * speed

func _on_enemy_destroyed() -> void:
	queue_free()
