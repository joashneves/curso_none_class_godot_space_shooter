extends Node2D

@onready var enemy_1 = preload("uid://bpptt8tsea0r3")
@onready var enemy_2 = preload("uid://c8b2i8xl56upk")
@onready var enemy_3 = preload("uid://cgomvdd7tofuy")

var enemy_3_instante : Node2D = null

var is_ending_level : bool = false
var is_enemy_3_in_scene : bool = false
@export var enemy_timer_spawn = 2

func _ready() -> void:
	is_ending_level = false
	is_enemy_3_in_scene = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_timer_spawn -= delta
	if enemy_timer_spawn < 0:
		enemy_spawn()
		enemy_timer_spawn = randf_range(1,3)
		
	if is_enemy_3_in_scene && is_instance_valid(enemy_3_instante):
		if enemy_3_instante.position.y >= 580:
			is_enemy_3_in_scene = false

func enemy_spawn():
	if GameManager.level >= 1 && !is_ending_level:
		var enemy_spawn = enemy_1.instantiate()
		enemy_spawn.global_position = [Vector2(138, -36),Vector2(50, -36), Vector2(100, -36), Vector2(270, -36)].pick_random()
		add_child(enemy_spawn)

	if GameManager.level >= 2 && !is_ending_level:
		var enemy_2_instante = enemy_2.instantiate()
		enemy_2_instante.global_position = [Vector2(138, -36),Vector2(50, -36), Vector2(100, -36), Vector2(270, -36)].pick_random()
		add_child(enemy_2_instante) 
		
	if GameManager.level >= 3 && !is_enemy_3_in_scene:
		is_ending_level = true
		is_enemy_3_in_scene = true
		enemy_3_instante = enemy_3.instantiate()
		enemy_3_instante.global_position =  Vector2(100, -36)
		add_child(enemy_3_instante)
