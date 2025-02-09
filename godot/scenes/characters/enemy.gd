extends PivotCharacter

signal destroyed

@export var collision_damage = 3

func _ready() -> void:
	super()
	direction = Vector2(1,0.1)
	start_firing()

func start_firing():
	$Body/Gun.fire(get_forward_vector())

func destroy():
	queue_free()
	destroyed.emit()

func _on_gun_reloaded() -> void:
	$Body/Gun.fire(get_forward_vector())

func _on_hurtbox_take_hit(_hitbox: Hitbox, _modifier: float) -> void:
	destroy()

func _on_hitbox_deal_hit(_hurtbox: Hurtbox, _modifier: float) -> void:
	destroy()
