# Detected by HurtBox
class_name HitBox
extends Area2D

#warning-ignore:UNUSED_SIGNAL
signal detected(hurtbox) # not ideal, but signal is triggered from the hurtbox class >_>

@export var damage := 1
@export var knockback := 10

var disabled := false : set = set_disabled
var knockback_direction := Vector2.ZERO

func set_disabled(state):
	disabled = state
	set_deferred("monitorable", not disabled)
