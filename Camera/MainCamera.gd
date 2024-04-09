extends IntersectionDetectingCamera

class_name MainCamera

@export var LOOKAROUND_SPEED = 0.005

@export
var SCALE_UP_FACTOR = 10000.

@export
var player: Node3D

@export
var mini_camera: MiniCamera

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
		
		
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot_minicam"):
		var space_state = get_world_3d().direct_space_state
		var screen_center = Vector2(get_viewport().get_visible_rect().size.x / 2, get_viewport().get_visible_rect().size.y / 2)
		var from = project_ray_origin(screen_center)
		var ray_direction = project_ray_normal(screen_center)
		var to = from + ray_direction * SCALE_UP_FACTOR
		var collision_mask = 0b1 # Environment layer
		var query = PhysicsRayQueryParameters3D.create(from, to, collision_mask)
		var result = space_state.intersect_ray(query)
		if "position" in result:
			mini_camera.global_position = result["position"]
			var up = Vector3(0,1,0)
			var camera_direction = result["normal"]
			var is_floor = camera_direction == up
			if is_floor:
				mini_camera.global_position += up * mini_camera.MOBILE_CAM_HEIGHT
				camera_direction = ray_direction - ray_direction.dot(up) * up
			mini_camera.look_at(mini_camera.global_position + camera_direction, up)
			mini_camera.show_display(is_floor)
	
	if Input.is_action_just_pressed("clear_minicam"):
		mini_camera.hide_display()
