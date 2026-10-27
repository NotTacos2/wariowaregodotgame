extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer
@onready var readytext: RichTextLabel = $ready
@onready var yestext: RichTextLabel = $chemicaltext
@onready var readybutton: Button = $Button
@onready var redchemical: TextureButton = $redchemical
@onready var bluechemical: TextureButton = $bluechemical
@onready var greenchemical: TextureButton = $greenchemical
@onready var purplechemical: TextureButton = $purplechemical

var selectedred = false # red, blue
var selectedblue = false
var selectedgreen = false
var selectedpurple = false
var wasitred = false # red, blue
var wasitblue = false
var wasitgreen = false
var wasitpurple = false
var secondanswer := -1
var timer_end = false
var canclicksubmitbutton = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await themed_timer.Timer(0.5)
	readytext.text = "Set"
	await themed_timer.Timer(0.5)
	readytext.text = "Go!"
	await themed_timer.Timer(0.5)
	var random = randf()
	if (random < 0.25):
		readytext.text = "Red and Green!"
		yestext.text = ""
		wasitred = true
		wasitgreen = true
		secondanswer = 0
		canclicksubmitbutton = true
	elif (random < 0.5):
		readytext.text = "Red and Blue!"
		yestext.text = ""
		wasitred = true
		wasitblue = true
		secondanswer = 0
		canclicksubmitbutton = true
	elif (random < 0.75):
		readytext.text = "Green and Purple!"
		yestext.text = ""
		wasitgreen = true
		wasitpurple = true
		secondanswer = 0
		canclicksubmitbutton = true
	else:
		readytext.text = "Blue and Purple!"
		yestext.text = ""
		wasitblue = true
		wasitpurple = true
		canclicksubmitbutton = true
	await themed_timer.Timer(2.5)
	timer_end = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://level_scene.tscn")

func _on_button_pressed() -> void:
	if canclicksubmitbutton == false:
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://level_scene.tscn")
	if selectedblue == false and selectedgreen == false and selectedred == false and selectedpurple == false:
		return
	if (selectedred == wasitred and selectedgreen == selectedgreen) or (selectedred == wasitred and selectedblue == selectedblue) or (selectedgreen == wasitgreen and selectedpurple == selectedpurple) or (selectedblue == wasitblue and selectedpurple == selectedpurple):
		if Global.minigames_done >= 3:
			get_tree().change_scene_to_file("res://winner.tscn")
		else:
			get_tree().change_scene_to_file("res://level_scene.tscn")
	else:
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://level_scene.tscn")


func _on_button_2_pressed() -> void:
	selectedblue = false
	selectedred = false
	selectedgreen = false
	selectedpurple = false
	redchemical.visible = true
	bluechemical.visible = true
	greenchemical.visible = true
	purplechemical.visible = true
