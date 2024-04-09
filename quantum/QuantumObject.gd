extends Node3D

class_name QuantumObject

# eg RigidBody3D
@export_group("Internal")
@export
var collider: CollisionObject3D

func quantum_hide():
	collider.set_collision_layer_value(4, false)
	collider.set_collision_mask_value(2, false)
	hide()
	
func quantum_show():
	collider.set_collision_layer_value(4, true)
	collider.set_collision_mask_value(2, true)
	show()

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(collider, "QuantumObject must have a collider")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
