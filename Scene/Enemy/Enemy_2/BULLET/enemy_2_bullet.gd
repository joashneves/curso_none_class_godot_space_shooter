extends Area2D

@export var bullet_speed : float = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += bullet_speed * delta
	if position.y > 560:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.player_health -= 1;
		print("Encostei no player vida : ", body.player_health)
		body.anim.play("Hit")
		if body.player_health < 0:
			body.Player_Death()
			body.queue_free()
		queue_free()
