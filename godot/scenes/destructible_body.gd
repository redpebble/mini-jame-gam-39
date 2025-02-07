class_name DestructibleBody extends CharacterBody2D

signal hp_changed(current, max)
signal destroyed

@export var max_hp: int
var hp: int

func set_hp(value):
	print("set: %s -> %s"%[hp, value])
	if hp && hp == value: return
	hp = value
	hp_changed.emit(hp, max_hp)

func deal_damage(body, dmg):
	if body && body.has_method("take_damage"):
		body.take_damage(dmg)

func take_damage(dmg: int):
	hp -= dmg
	hp = clamp(hp, 0, max_hp)
	hp_changed.emit(hp, max_hp)
	print('%s took %s damage: %s/%s remaining'%[name, dmg, hp, max_hp])
	if hp <= 0:
		destroy()

func destroy():
	# explosion?
	queue_free()
	destroyed.emit()
	print('%s destroyed'%[name])

func _ready() -> void:
	set_hp(max_hp)