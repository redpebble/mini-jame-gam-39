extends PivotCharacter

signal hp_changed(current, max)
signal destroyed

@export var max_hp: int = 10

var hp = max_hp

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("left", "right")
	super(delta)

func _process(_delta: float) -> void:
	if Input.is_action_pressed('fire'):
		$Body/Gun.fire(get_forward_vector())

func _on_hurtbox_take_hit(hitbox: Hitbox, modifier: float) -> void:
	print('took damage: ' + str(hitbox.damage * modifier))
	hp -= (hitbox.damage * modifier)
	hp = clamp(hp, 0, max_hp)
	hp_changed.emit(hp, max_hp)
	if hp == 0:
		queue_free()
		destroyed.emit()
