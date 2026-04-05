extends Area2D

@export var speed : float = 200
var direction : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = direction.angle() - PI/2

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.player_health -= 1
		body.anim.play("Hit")
		queue_free()
		if body.player_health < 0:
			body.Player_Death()
			body.queue_free()


func _on_timer_timeout() -> void:
	queue_free()
