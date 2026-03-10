extends Parallax2D

@export var speed : float = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var layer = self
	if layer is Parallax2D:
		layer.autoscroll.y += speed * delta	
		# 1000 ta bom print(layer.autoscroll.y)
