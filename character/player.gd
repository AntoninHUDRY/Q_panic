extends CharacterBody3D

class_name Player

@export
var mini_camera: MiniCamera
@export
var quantum_controller: QuantumController

@export_group("internal")
@export
var main_camera: MainCamera

var default_speed = 5.0
var crouch_speed = 0.5*default_speed
var sprint_speed = 1.5*default_speed
var jump_velocity = 4.0


var default_height = 1
var crouch_height = 0.5

var sprinting = false
var crouched = false

@onready var collision_shape = $PlayerCollision
@onready var bonker = $HeadBonker

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8

# Preload the pause menu scene
var pause_menu_scene := preload("res://Menu/pause_menu.tscn")
var pause_menu_instance: Node

func _ready():
	main_camera.mini_camera = mini_camera
	quantum_controller.cameras.append(main_camera)
	quantum_controller.cameras.append(mini_camera.camera)
	# Instance the pause menu from the preloaded scene
	pause_menu_instance = pause_menu_scene.instantiate()
	# Add the pause menu instance to the current scene
	add_child(pause_menu_instance)
	# Make sure the pause menu is hidden initially
	pause_menu_instance.visible = false

func _process(delta):
	if Input.is_action_just_pressed("exit_game"):
		# Pause scene
		get_tree().paused = true
		# Show menu
		pause_menu_instance.visible = true
		# release the mouse
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	
	var speed = default_speed
	
	var head_bonked = false
	if bonker.is_colliding():
		head_bonked = true
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	if head_bonked:
		velocity.y = -2
	
	# handle crouch.
	crouched = false
	if Input.is_action_pressed("crouch") and is_on_floor():
		collision_shape.scale.y -= crouch_speed * delta
		speed = crouch_speed
		crouched = true
	elif not head_bonked:
		collision_shape.scale.y += crouch_speed * delta
		crouched = false
	collision_shape.scale.y = clamp(collision_shape.scale.y, crouch_height, default_height)

	if Input.is_action_just_pressed("sprint") and is_on_floor() and not crouched:
		sprinting = true
	elif Input.is_action_just_released("sprint") and is_on_floor() and not crouched:
		sprinting = false
	if sprinting:
		speed = sprint_speed
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and !Singleton.listening:
		if !$walk.playing and is_on_floor():
			$walk.play()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()


func _on_button_pressed():
	$MainCamera/tuto.visible = !$MainCamera/tuto.visible



