extends CharacterBody2D

@onready var shot_point: Marker2D = $Shot_point
@export var bullet_scene : PackedScene;
@export var player_speed : float = 2

@export var fire_rate : float = 0.2;
var can_shoot : bool = true;

@export var left_limit : float
@export var right_limit : float 
@export var bottom_limit : float
@export var top_limit : float

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
	var bullet = bullet_scene.instantiate()
	bullet.global_position = shot_point.global_position;
	get_tree().current_scene.add_child(bullet)
	bullet.add_to_group("Player_Bullet")
