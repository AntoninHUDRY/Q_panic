extends IntersectionDetectingCamera

@export var LOOKAROUND_SPEED = 0.005

@export
var SCALE_UP_FACTOR = 10000.

@export
var player: Node3D

var dir: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * LOOKAROUND_SPEED)
		rotate_x(-event.relative.y * LOOKAROUND_SPEED)
		rotation.x = clampf(rotation.x, -deg_to_rad(89), deg_to_rad(89))

