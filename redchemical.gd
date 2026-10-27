extends TextureButton
@onready var parent = $".."

func _on_pressed() -> void:
	hide()
	parent.selectedred = true
