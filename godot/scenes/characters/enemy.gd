extends PivotCharacter

signal destroyed

@export var collision_damage = 3

var is_destroyed = false

func _ready() -> void:
	super()
	start_firing()

func start_firing():
	$Body/Gun.fire(get_forward_vector())

func destroy():
	if is_destroyed: return
	queue_free()
	destroyed.emit()
	is_destroyed = true

func _on_gun_reloaded() -> void:
	$Body/Gun.fire(get_forward_vector())

func _on_hurtbox_take_hit(_hitbox: Hitbox, _modifier: float) -> void:
	destroy()

func _on_hitbox_deal_hit(_hurtbox: Hurtbox, _modifier: float) -> void:
	destroy()
