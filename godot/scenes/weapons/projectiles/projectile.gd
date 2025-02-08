class_name Projectile extends Node2D

var direction: Vector2 = Vector2.RIGHT
var speed: float = 1000
var is_enemy_weapon: bool = false

func init(dir, spd, global_trns, is_enemy):
	direction = dir
	speed = spd
	global_transform = global_trns
	is_enemy_weapon = is_enemy

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _ready() -> void:
	if is_enemy_weapon:
		$HitBox.collision_layer = 2
		$HitBox.collision_mask = 1

func _on_hit_box_detected(hurtbox: Variant) -> void:
	queue_free()
