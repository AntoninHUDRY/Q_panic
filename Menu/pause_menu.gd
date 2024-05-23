extends CanvasLayer


func _on_resume_button_pressed():
	# Unpause the scene
	get_tree().paused = false
	# Hide the pause menu
	self.visible = false
	# Capture the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_quit_button_pressed():
	# Go to the main menu
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
