# Allows its owner to detect hits and take damage
class_name Hurtbox
extends Area2D

signal invincibility_started
signal invincibility_ended

signal take_hit(hitbox: Hitbox, modifier: float)

@export var allow_retrigger := false ## Hitboxes don't need to reenter this area to inflict damage.
@export var automatic_invincibility := false
@export_range(0.1, 3, 0.1) var invincibilty_duration : float = 2.0 # seconds
@export var friendly_groups : Array[String] = []
@export var last_registered_hit := {
	"damage" : 0,
	"direction" : 0,
}

var invincible := false : set = set_invincible
var i_timer : SceneTreeTimer = null


func _init() -> void:
	# The hurtbox should detect hits but not deal them. This variable does that.
	monitorable = false


func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	connect("invincibility_started", self._on_invincibility_started)
	connect("invincibility_ended", self._on_invincibility_ended)


func _on_area_entered(hitbox):
	if not allow_retrigger:
		register_hit(hitbox)

func _process(delta):
	if allow_retrigger:
		var hitboxes = get_overlapping_areas()
		for hitbox in hitboxes:
			register_hit(hitbox, delta * 0.5)


func register_hit(hitbox : Hitbox, modifier := 1.0):
	if hitbox.owner == self:
		return
	if is_friendly(hitbox):
		return
	
	take_hit.emit(hitbox, modifier)
	last_registered_hit.damage = hitbox.damage * modifier
	
	var knockback_vec = -global_position.direction_to(hitbox.global_position)
	if hitbox.get("knockback_direction") != null:
		knockback_vec = hitbox.knockback_direction
	#take_knockback.emit(hitbox.knockback, knockback_vec) # todo: redo this if need knockback
	last_registered_hit.direction = knockback_vec
	
	# double check this export variable if experiencing issues
	if automatic_invincibility:
		start_invincibility(invincibilty_duration)
	
	hitbox.deal_hit.emit(self, modifier)


## Invincibility ##
func set_invincible(state):
	invincible = state
	if invincible:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration : float = invincibilty_duration):
	self.set_invincible(true)
	# start invincibility timer
	i_timer = get_tree().create_timer(duration, false)
	i_timer.connect("timeout", self.set_invincible.bind(false))

func _on_invincibility_started():
	set_deferred("monitoring", false)
func _on_invincibility_ended():
	set_deferred("monitoring", true)

func is_friendly(hitbox : Hitbox):
	for g in friendly_groups:
		if hitbox.owner.is_in_group(g):
			return true
	return false
