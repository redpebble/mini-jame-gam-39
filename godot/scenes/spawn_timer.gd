extends Timer

signal tick(index: int)

var spawn_tick = 0

func _ready() -> void:
	emit_tick()

func _on_timeout() -> void:
	spawn_tick += 1
	emit_tick()

func emit_tick():
	tick.emit(spawn_tick)
	print("spawn tick " + str(spawn_tick))
