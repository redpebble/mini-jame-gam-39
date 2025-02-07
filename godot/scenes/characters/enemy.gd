extends Character

@export var collision_damage = 5
@onready var gun = $Gun
var direction: Vector2 = Vector2.DOWN

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * speed
	look_at(position + velocity)
	rotation += PI/2
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		deal_damage(collision.get_collider(), collision_damage)
		
		# spawn explosion?

func _on_gun_reloaded() -> void:
	gun.fire()

func _ready() -> void:
	super()
	gun.fire()