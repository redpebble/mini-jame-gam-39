# Detected by Hurtbox
class_name Hitbox
extends Area2D

#warning-ignore:UNUSED_SIGNAL
signal deal_hit(hurtbox: Hurtbox, modifier: float) # not ideal, but signal is triggered from the hurtbox class >_>

@export var damage := 1
@export var knockback := 10

var disabled := false : set = set_disabled
var knockback_direction := Vector2.ZERO

func set_disabled(state):
	disabled = state
	set_deferred("monitorable", not disabled)
