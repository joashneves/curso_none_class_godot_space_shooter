extends CharacterBody2D

@onready var shot_point: Marker2D = $Shot_point
@onready var shot_point_left: Marker2D = $Shot_point_left
@onready var shot_point_right: Marker2D = $Shot_point_Right

@onready var anim : AnimationPlayer = $AnimationPlayer

@onready var detector: Area2D = $Detector
@export var bullet_scene : PackedScene;

@export var player_health : int = 3
@export var player_speed : float = 2
@export var player_speed_power_up : float = 4
var player_speed_default : float = player_speed;

@export var power_up_timer : float = 5
@export var power_up_charger : float = 5;

@export var power_up_shoot_active : bool = false

@export var fire_rate : float = 0.2;
var can_shoot : bool = true;

@export var left_limit : float
@export var right_limit : float 
@export var bottom_limit : float
@export var top_limit : float


var explosion_scene = preload("res://Scene/Particulas/Explosion_VFX.tscn")

func _ready() -> void:
	player_speed = player_speed_default

func _process(delta: float) -> void:
	powerups(delta)

func _physics_process(delta: float) -> void:
	var input_vector := Vector2.ZERO;
	
	input_vector.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	input_vector.y = (Input.get_action_strength("move_down") - Input.get_action_strength("move_up")) 
	
	# Tiro contuno do jogador		
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
		can_shoot = false
		# Cria um timer, para que o possa ir para proxima linhasdw 
		await get_tree().create_timer(fire_rate).timeout
		can_shoot = true
	
	position += input_vector * player_speed
	move_and_slide()
	
	#Limiter da movimentação com Clamp
	global_position.x = clamp(global_position.x, left_limit, right_limit)
	global_position.y = clamp(global_position.y, top_limit, bottom_limit)

func shoot() -> void:
	if !power_up_shoot_active:
		shoot_single()
	elif power_up_shoot_active:
		shoot_triple()
	
func shoot_single() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = shot_point.global_position;
	get_tree().current_scene.add_child(bullet)
	bullet.add_to_group("Player_Bullet")
		

func shoot_triple() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = shot_point.global_position;
	get_tree().current_scene.add_child(bullet)
	bullet.add_to_group("Player_Bullet")
	
	var bullet_left = bullet_scene.instantiate()
	bullet_left.global_position = shot_point_left.global_position;
	get_tree().current_scene.add_child(bullet_left)
	bullet_left.add_to_group("Player_Bullet")
	
	var bullet_right = bullet_scene.instantiate()
	bullet_right.global_position = shot_point_right.global_position;
	get_tree().current_scene.add_child(bullet_right)
	bullet_right.add_to_group("Player_Bullet")
	

func powerups(delta: float) -> void:
	if power_up_timer > 0:
		power_up_timer -= delta
	if power_up_timer <= 0:
		player_speed = player_speed_default
		power_up_shoot_active = false
	for area in detector.get_overlapping_areas():
		if area.is_in_group("power_up_speed"):
			area.queue_free()
			player_speed = player_speed_power_up
			power_up_timer = power_up_charger
		elif area.is_in_group("power_up_shoot"):
			area.queue_free()
			power_up_shoot_active = true
			power_up_timer = power_up_charger

func Player_Death() -> void:
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
