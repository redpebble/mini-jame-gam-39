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
	if position.distance_to(Vector2(500,500)) > 1000:
		queue_free()

func _ready() -> void:
	if is_enemy_weapon:
		$Hitbox.collision_layer = 2
		$Hitbox.collision_mask = 1

func _on_hitbox_deal_hit(_hurtbox: Hurtbox, _modifier: float) -> void:
	queue_free()
