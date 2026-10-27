extends Node2D
@onready var head_container: HBoxContainer = $headcontainer
@onready var head: TextureRect = $headcontainer/head
@onready var head_2: TextureRect = $headcontainer/head2
@onready var head_3: TextureRect = $headcontainer/head3
@onready var head_4: TextureRect = $headcontainer/head4
@onready var head_5: TextureRect = $headcontainer/head5
@onready var level: RichTextLabel = $LevelCount
@onready var timer: RichTextLabel = $Timer
@onready var hint: RichTextLabel = $hinttext

var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.lives == 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
	else:
		await Timer(5.0)
	
		if Global.minigames_done < 3:
			Global.minigames_done = Global.minigames_done + 1
			if Global.hardmode == false:
				get_tree().change_scene_to_file("res://minigame_" + str(Global.minigames_done) + ".tscn")
			else:
				get_tree().change_scene_to_file("res://hardminigame_" + str(Global.minigames_done) + ".tscn")
		else:
			get_tree().change_scene_to_file("res://title_screen.tscn")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match Global.lives:
		4: 
			head.hide()
		3:
			head_2.hide()
			head.hide()
		2:
			head_3.hide()
			head_2.hide()
			head.hide()
		1:
			head_4.hide()
			head_3.hide()
			head_2.hide()
			head.hide()
		0:
			head_container.hide()
	timer.text = str(time)
	if Global.hardmode == false:
		level.text = "Level " + str(Global.minigames_done)
	else:
		level.text = "Level " + str(Global.minigames_done) + " (HARD)"
		
	if (Global.minigames_done == 0 and Global.hardmode == true):
		hint.text = "Platform! Press space to jump to collect heads before time runs out to win. Beware of cursed heads!"
	elif (Global.minigames_done == 1 and Global.hardmode == true):
		hint.text = "Click on the heads before time runs out to win. Beware of cursed heads!"
	elif (Global.minigames_done == 2):
		hint.text = "Chemistry! Mix the two chemicals shown below."
	elif (Global.minigames_done == 0):
		hint.text = "Press space to jump to collect heads before time runs out to win."
	elif (Global.minigames_done == 1):
		hint.text = "Click on the heads before time runs out to win."
	
func Timer(start_time: float):
	time = start_time
	while time > 0.0:
		await wait(0.1)
		time -= 0.1
	return
		
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
