extends Node2D

@onready var enemy_1 = preload("uid://bpptt8tsea0r3")

@export var enemy_timer_spawn = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_timer_spawn -= delta
	if enemy_timer_spawn < 0:
		enemy_1_spawn()
		enemy_timer_spawn = randf_range(3,10)

func enemy_1_spawn():
		var enemy_spawn = enemy_1.instantiate()
		enemy_spawn.global_position = [Vector2(138, -36),Vector2(50, -36), Vector2(100, -36), Vector2(270, -36)].pick_random()
		add_child(enemy_spawn)
