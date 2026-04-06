extends Control

@onready var fade_out_effect : ColorRect = $ColorRect

@export var fade_out_speed : float = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_out_effect.color.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fade_out_effect.color.a += fade_out_speed * delta
	
	if fade_out_effect.color.a >= 1:
		queue_free()
