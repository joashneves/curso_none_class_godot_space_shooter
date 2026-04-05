extends Area2D

enum State { ENTER, ATTACK, LEAVE}

@onready var anim: AnimationPlayer = $AnimationPlayer

@export var enemy_3_health : int = 3

@export var speed : float = 100
@export var stop_y : float = 180
@export var attack_time : float = 3
@export var shoot_interval : = 0.5

@export var bullet_scene : PackedScene
@export var radial_bullets : int = 12
@export var radial_bullet_speed : float = 200

const EXPLOSION_VFX = preload("uid://b1gn1m7t7akxn")


var state : State = State.ENTER

var attack_timer : float = 0
var shoot_timer : float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		State.ENTER:
			position.y += speed * delta
			if position.y >= stop_y:
				position.y = stop_y
				state = State.ATTACK
				attack_timer = attack_time
				shoot_timer = shoot_interval
		State.ATTACK:
			attack_timer -= delta
			shoot_timer -= delta
			if shoot_timer <= 0:
				shoot_radial()
				shoot_timer = shoot_interval
			if attack_timer <= 0:
				state = State.LEAVE
				
		State.LEAVE:
			position.y += speed * delta
			
			if position.y > 560:
				queue_free()
			
			
func shoot_radial() -> void:
	var count := radial_bullets
	if count <= 0:
		return
		
	var angle_step := TAU / float(count)
	
	for i in range(count):
		var angle := angle_step * i
		var dir := Vector2.RIGHT.rotated(angle)
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.direction = dir
		bullet.speed = radial_bullet_speed
		get_tree().current_scene.add_child(bullet)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.Player_Death()
		body.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_Bullet"):
		enemy_3_health -= 1
		area.queue_free()
		anim.play('hit')
		if enemy_3_health <= 0:
			print("Morri")
			var vfx = EXPLOSION_VFX.instantiate()
			vfx.global_position = global_position
			get_parent().add_child(vfx)
			queue_free()
