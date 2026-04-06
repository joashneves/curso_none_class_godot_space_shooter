extends CanvasLayer

@onready var points_label: Label = $Points_Label
@onready var level_label: Label = $Level_Label

@onready var player := get_tree().get_first_node_in_group("player")
@onready var lives_container : HBoxContainer = $HBoxContainer
@export var max_lives : int = 3;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	points_label.text = "Score : " + str(GameManager.points)
	level_label.text = "Level : " + str(GameManager.level)

	Update_UI_Lives()
	
func Update_UI_Lives() -> void:
	if is_instance_valid(player):
		var lives = player.player_health
		lives = clamp(lives, 0, max_lives)
		
		for i in range(max_lives):
			lives_container.get_child(i).visible = i < lives
		
