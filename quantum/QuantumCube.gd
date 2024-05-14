extends QuantumObject

class_name QuantumCube


@export
var material: StandardMaterial3D

@export_group("Internal")
@export
var mesh: MeshInstance3D

var highlighted = false
@onready var outline = $RigidBody3D/MeshInstance3D/outline

var holder = null
var holded = false
var pull_power = 10
var rotation_power = 0.1
var rotation_count = 0
var throw_power = 3

func quantum_hide():
	collider.set_collision_layer_value(4, false)
	collider.set_collision_mask_value(2, false)
	hide()
	
func quantum_show():
	collider.set_collision_layer_value(4, true)
	collider.set_collision_mask_value(2, true)
	enable_button_interactions()
	show()

func _ready():
	var surface_count = mesh.get_surface_override_material_count()
	for i in range(surface_count):
		mesh.set_surface_override_material(i, material)
		
func _process(delta):
	if holded:
		var a = $RigidBody3D.global_transform.origin
		var b = holder.get_node("Hand").global_transform.origin
		$RigidBody3D.set_linear_velocity((b-a)*pull_power)
		
		
		if rotation_count != 0:
			var angle = $RigidBody3D.get_rotation_degrees()
			$RigidBody3D.set_angular_velocity((-angle)*rotation_power)
			rotation_count = rotation_count - 1
			if rotation_count == 0:
				$RigidBody3D.set_angular_velocity(Vector3(0,0,0))

func _highlight() -> void :
	highlighted = true
	outline.visible = true

func _unhighlight() -> void :
	highlighted = false
	outline.visible = false

func _on_interactable_focused(interactor):
	_highlight()


func _on_interactable_interacted(interactor):
	if holded:
		rotation_count = 200


func _on_interactable_unfocused(interactor):
	_unhighlight()


func _on_interactable_holded(interactor):
	
	holded = true
	holder = interactor


func _on_interactable_released(interactor):
	holded = false
	holder = null
	$RigidBody3D.set_linear_velocity(Vector3(0,0,0))
	$RigidBody3D.set_angular_velocity(Vector3(0,0,0))
	rotation_count = 0
	
func _on_interactable_thrown(interactor):
	var a = $RigidBody3D.global_transform.origin
	var b = holder.global_transform.origin
	holded = false
	holder = null
	$RigidBody3D.set_linear_velocity(-(b-a)*throw_power)
	pass # Replace with function body.
