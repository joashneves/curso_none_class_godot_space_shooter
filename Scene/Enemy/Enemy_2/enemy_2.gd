extends Area2D

const ENEMY_2_BULLET = preload("uid://bp32rthqs2pgg")

@onready var enemy_2_speed : float = 200

@onready var bulletpoint: Marker2D = $bulletpoint

var player_ref : Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_ref = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += enemy_2_speed * delta
	
	if position.y > 560:
		queue_free()


func _on_timer_timeout() -> void:
	if player_ref:
		var bullet = ENEMY_2_BULLET.instantiate()
		bullet.global_position = bulletpoint.global_position
		get_parent().add_child(bullet)
