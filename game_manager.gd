extends Node

@export var level : int = 1
@export var levelThershold : int = 100
@export var points : int = 0

const LEVEL_COMPLETE = preload("uid://bwcupxahyav2r")
const MAIN = preload("uid://bd3icnjda5bti")
const GAME_OVER = preload("uid://c15teu8ebo1ol")
const FADE_OUT = preload("uid://dx4872kq1rn3m")



func Add_Points(value : int) -> void:
	points += value
	
	if points > levelThershold:
		Add_level()
		
	
func Add_level() -> void:
	level += 1
	levelThershold *= level

func On_Final_Enemy_Defeated() -> void:
	get_tree().paused = true
	var level_complete = LEVEL_COMPLETE.instantiate()
	get_tree().root.add_child(level_complete)
	
func Game_over() -> void:
	var fade_out = FADE_OUT.instantiate()
	get_tree().root.add_child(fade_out)
	await get_tree().create_timer(0.5).timeout
	var game_over = GAME_OVER.instantiate()
	get_tree().root.add_child(game_over)
