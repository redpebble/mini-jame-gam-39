extends Character

@onready var gun = $Gun

func _process(_delta: float) -> void:
	if Input.is_action_pressed('fire'):
		gun.fire(velocity)

# func _physics_process(_delta: float) -> void:
# 	var direction = Input.get_vector('left', 'right', 'up', 'down')
# 	velocity = direction * speed
# 	move_and_slide()