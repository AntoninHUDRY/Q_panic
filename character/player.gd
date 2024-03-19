extends CharacterBody3D


var default_speed = 5.0
var crouch_speed = 0.5*default_speed
var sprint_speed = 1.5*default_speed
var jump_velocity = 4.5


var default_height = 1
var crouch_height = 0.5

var sprinting = false
var crouched = false

@onready var collision_shape = $PlayerCollision
@onready var bonker = $HeadBonker

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8


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
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()
