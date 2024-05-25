class_name LevelSelect
extends Control

@onready var quit_to_menu = $VBoxContainer/QuitToMenu as Button


signal exit_level_select

func _ready():
	quit_to_menu.button_down.connect(_on_quit_to_menu_pressed)
	set_process(false)

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://level/level 1/level1.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://level/level 2/level2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://level/level 3/level3.tscn")


func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://level/level 4/level4.tscn")


func _on_level_5_pressed():
	get_tree().change_scene_to_file("res://level/level 5/level5.tscn")


func _on_level_6_pressed():
	get_tree().change_scene_to_file("res://level/level 6/level6.tscn")


func _on_level_7_pressed():
	get_tree().change_scene_to_file("res://level/level 7/level7.tscn")


func _on_level_8_pressed():
	get_tree().change_scene_to_file("res://level/level 8/level8.tscn")


func _on_quit_to_menu_pressed() -> void:
	exit_level_select.emit()
	set_process(false)
