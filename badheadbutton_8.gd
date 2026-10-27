extends TextureButton

func _on_pressed() -> void:
	Global.minigames_done -= 1
	Global.lives -= 1
	get_tree().change_scene_to_file("res://level_scene.tscn")			
