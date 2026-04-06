extends ColorRect

@export var fade_in_speed : float = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color.a = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	color.a -= fade_in_speed * delta
	
	if color.a <= 0.0:
		queue_free()
