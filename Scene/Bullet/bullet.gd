extends Area2D

@export var bullet_speed : float = 400;


func _process(delta: float) -> void:
	position.y -= bullet_speed * delta;

	if position.y <= -64:
		queue_free()
		#print("Tiro destruido")
