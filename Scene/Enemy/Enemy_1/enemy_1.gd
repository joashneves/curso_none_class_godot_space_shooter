extends Area2D

@export var enemy_speed : float = 100
@export var power_up_chance : float = 8
const EXPLOSION_VFX = preload("uid://b1gn1m7t7akxn")
const POWER_UP_SPEED = preload("uid://c5a0c6ofhose4")
const POWER_UP_SHOOT = preload("uid://bay2yn1oit5ch")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += enemy_speed * delta;
	if position.y > 560:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_Bullet"):
		Destroy_VFX()
		var range_number = randf_range(0, 10)
		if range_number > power_up_chance:
			Create_PowerUp()
		queue_free()
		area.queue_free()
		
func Destroy_VFX():
	var expolision_vfx = EXPLOSION_VFX.instantiate()
	expolision_vfx.global_position = global_position
	get_parent().add_child(expolision_vfx)

func Create_PowerUp():
	var escolha = [POWER_UP_SHOOT, POWER_UP_SPEED].pick_random()
	
	var power_up = escolha.instantiate()
	power_up.global_position = global_position
	get_parent().add_child(power_up)
