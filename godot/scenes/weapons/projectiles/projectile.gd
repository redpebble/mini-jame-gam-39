class_name Projectile extends DestructibleBody

var speed: float = 1000
var damage: int = 1

func init(vel, spd, dmg, global_trns, is_enemy_weapon):
	speed = spd
	damage = dmg
	global_transform = global_trns
	if is_enemy_weapon:
		collision_layer = 2
		collision_mask = 1
	velocity = (vel / 7) + (-transform.y * speed)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		deal_damage(collision.get_collider(), damage)
		destroy()
