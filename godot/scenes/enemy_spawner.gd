extends Node2D

signal enemy_spawned(enemy)

@export var enemies_per_ring: int = 12
@export var initial_distance: float = 700

var enemy_scene = preload("res://scenes/characters/enemy.tscn")
var spawn_pattern: Array = []

func _ready() -> void:
	var enemy1 = null # default
	var enemy2 = {
		direction = Vector2(-1, 0.2),
	}
	build_enemy_spawn_group(enemy1, 4, 3)
	build_enemy_spawn_group(enemy2, 8, 9)

func _on_spawn_timer_tick(index: int) -> void:
	if spawn_pattern.size() <= index: return
	spawn_enemies(spawn_pattern[index])

func build_enemy_spawn_group(enemy_config, num_enemies: int, tick: int):
	var enemy_config_base = default_enemy_config.duplicate(true)
	if enemy_config:
		for key in enemy_config.keys():
			enemy_config_base[key] = enemy_config[key]
	var config_list = []
	var angle_interval = 2*PI / num_enemies
	for i in num_enemies:
		var config = enemy_config_base.duplicate(true)
		config.angle = angle_interval * i
		config_list.append(config)
	
	if spawn_pattern.size() <= tick: spawn_pattern.resize(tick + 1)
	if !spawn_pattern[tick]: spawn_pattern[tick] = []
	spawn_pattern[tick].append_array(config_list)

func spawn_enemies(config_list):
	if !config_list: return
	for config in config_list:
		spawn_enemy(config)

func spawn_enemy(config):
	if !config: return
	var enemy = enemy_scene.instantiate()
	if config:
		if config.has('distance'):         enemy.initial_distance = config['distance']
		if config.has('angle'):            enemy.initial_angle = config['angle']
		if config.has('speed'):            enemy.max_speed = config['speed']
		if config.has('acceleration'):     enemy.acceleration = config['acceleration']
		if config.has('direction'):        enemy.direction = config['direction']
		if config.has('collision_damage'): enemy.collision_damage = config['collision_damage']
	
	enemy.ready.connect(func(): enemy_spawned.emit(enemy))
	call_deferred('add_child', enemy)

var default_enemy_config = {
	distance = 800,
	angle = 0,
	speed = 200,
	acceleration = 1,
	direction = Vector2(1, 0.2),
	collision_damage = 3,
	# configure weapon?
}

var default_enemy_group_config = {
	num_enemies = 4,
	enemy_config = default_enemy_config.duplicate(true)
}
