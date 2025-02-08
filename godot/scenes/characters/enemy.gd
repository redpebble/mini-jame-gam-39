extends Node2D

signal destroyed

@export var collision_damage = 5
@onready var gun = $Gun

func _on_gun_reloaded() -> void:
	gun.fire(Vector2.from_angle(global_rotation - PI/2))

func take_damage(damage):
	queue_free()
	destroyed.emit()

func start_firing():
	gun.fire(Vector2.from_angle(global_rotation - PI/2))

func _on_hit_box_detected(hurtbox: Variant) -> void:
	queue_free()
	destroyed.emit()
