class_name PivotCharacter extends Node2D

@export var facing_out: bool = true
@export var max_speed: float = 1
@export var acceleration: float = 1
@export var initial_distance: float = 100
@export var initial_angle: float = 0

@onready var body = get_body()

var speed: float = 0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	rotation = initial_angle + PI/2 # so that angle zero is "up"
	body.position.x = initial_distance
	body.rotation += PI/2 * (1 if facing_out else -1) # just to rotate the sprite

func _physics_process(delta: float) -> void:
	direction = direction.normalized()
	body.position.x -= delta * speed * direction.y
	speed = lerp(speed, max_speed * direction.x, acceleration * delta)
	rotate(get_angular_speed(speed, body.position.x) * delta)

func get_body():
	return get_child(0)

func get_angular_speed(linear_speed: float, radius: float) -> float:
	return linear_speed / radius

func get_forward_vector():
	return Vector2.from_angle(global_rotation + (0 if facing_out else PI))
