extends Node

class_name QuantumObject

# eg RigidBody3D
@export
var collider: CollisionObject3D

func hide():
	collider.set_collision_layer_value(4, false)
	collider.set_collision_mask_value(2, false)
	collider.hide()
	
func show():
	collider.set_collision_layer_value(4, true)
	collider.set_collision_mask_value(2, true)
	collider.show()

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(collider, "QuantumObject must have a collider")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
