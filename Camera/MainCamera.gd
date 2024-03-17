extends IntersectionDetectingCamera

@export var LOOKAROUND_SPEED = 0.005

@export
var SCALE_UP_FACTOR = 10000.

var dir: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

# accumulators
var rot_x = 0
var rot_y = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	
	if event is InputEventMouseMotion:
		rot_x -= event.relative.x * LOOKAROUND_SPEED
		rot_y -= event.relative.y * LOOKAROUND_SPEED
		transform.basis = Basis()
		rotate_object_local(Vector3(0, 1, 0), rot_x)
		rotate_object_local(Vector3(1, 0, 0), rot_y)
		
	dir = Vector3.ZERO
	if Input.is_key_pressed(KEY_W):
		dir += Vector3(0,0,-1)
	if Input.is_key_pressed(KEY_S):
		dir += Vector3(0,0,1)
	if Input.is_key_pressed(KEY_A):
		dir += Vector3(-1,0,0)
	if Input.is_key_pressed(KEY_D):
		dir += Vector3(1,0,0)
		
func _physics_process(delta):
	translate_object_local(dir*delta*10)
		
