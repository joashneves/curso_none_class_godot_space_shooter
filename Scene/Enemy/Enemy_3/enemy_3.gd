extends Area2D

enum State { ENTER, ATTACK, LEAVE}

@export var speed : float = 100
@export var stop_y : float = 180
@export var attack_time : float = 3
@export var shoot_interval : = 0.5
@export var bullet_scene : PackedScene

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
		State.ATTACK:
			attack_timer -= delta
			
			if attack_timer <= 0:
				state = State.LEAVE
				
		State.LEAVE:
			position.y += speed * delta
			
			if position.y > 560:
				queue_free()
			
			
func shoot_radial() -> void:
	pass
