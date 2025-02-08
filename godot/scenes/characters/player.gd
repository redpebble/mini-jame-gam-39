extends Node2D

signal hp_changed(current, max)
signal destroyed

@export var max_hp: int = 10

@onready var gun = $Gun

var hp = max_hp

func _process(_delta: float) -> void:
	if Input.is_action_pressed('fire'):
		gun.fire(Vector2.from_angle(global_rotation - PI/2))

func take_damage(damage):
	hp -= damage
	hp = clamp(hp, 0, max_hp)
	hp_changed.emit(hp, max_hp)
	if hp == 0:
		queue_free()
		destroyed.emit()
