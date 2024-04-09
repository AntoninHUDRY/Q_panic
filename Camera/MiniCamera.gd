extends Node3D

class_name MiniCamera

@export
var player: Player
@export
var viewport: SubViewportContainer


@export_group("internal")
@export
var camera: IntersectionDetectingCamera
@export
var mobile_cam: Node3D
@export
var wall_cam: Node3D
@export
var MOBILE_CAM_HEIGHT = 1.5

func hide_display():
	visible = false
	camera.visible = false
	viewport.visible = false
	hide_all_models()

func show_display(is_floor: bool):
	hide_all_models()
	if is_floor:
		mobile_cam.show()
	else:
		wall_cam.show()
	visible = true
	camera.visible = true
	viewport.visible = true
	
func hide_all_models():
	mobile_cam.hide()
	wall_cam.hide()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	hide_display()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
