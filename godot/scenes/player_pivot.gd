extends Node2D

@export var max_speed: float = 3
@export var acceleration: float = 1
var speed: float = 0

func _physics_process(delta: float) -> void:
	var axis = Input.get_axis("left", "right")
	speed = lerp(speed, max_speed * axis, acceleration * delta)
	rotate(speed * delta)
