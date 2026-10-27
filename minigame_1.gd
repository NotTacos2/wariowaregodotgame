extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer

var heads_collected = 0
var timer_end = false

func _ready() -> void:
	await themed_timer.Timer(10.0)
	timer_end = true

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if heads_collected == 3:
		if Global.minigames_done > 3:
			get_tree().change_scene_to_file("res://winner.tscn")
		else:
			get_tree().change_scene_to_file("res://level_scene.tscn")
			
	if timer_end:
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://level_scene.tscn")			


func heads_collect() -> void:
	heads_collected = heads_collected + 1
	return
