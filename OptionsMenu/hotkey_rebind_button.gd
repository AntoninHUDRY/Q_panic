class_name HotKeyRebindButton

extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button

@export var action_name : String = "left"

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()

func set_action_name() -> void:
	label.text = "Unassigned"
	
	match action_name:
		"up":
			label.text = "Move Forward"
		"down":
			label.text = "Move Backward"
		"left":
			label.text = "Move Left"
		"right":
			label.text = "Move Right"
		"jump":
			label.text = "Jump"
		"crouch":
			label.text = "Crouch"
		"sprint":
			label.text = "Sprint"
		"shoot_minicam":
			label.text = "Shoot Minicam"
		"clear_minicam":
			label.text = "Clear Minicam"
		"interact":
			label.text = "Interact"
		"hold":
			label.text = "Hold Object"
		"release":
			label.text = "Release Object"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	if action_event is InputEventKey:
		var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
		button.text = "%s" % action_keycode
	elif action_event is InputEventMouseButton:
		var action_keycode = OS.get_keycode_string(action_event.button_index)
		button.text = "%s" % "Mouse Button " + str(action_event.button_index)

		


func _on_button_toggled(toggled_on):
	if toggled_on:
		button.text = "Press Any Key..."
		set_process_unhandled_key_input(toggled_on)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else :
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_for_key()

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.toggle_mode = false

func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
