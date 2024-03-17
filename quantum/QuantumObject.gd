extends Node

class_name QuantumObject

# eg RigidBody3D
@export
var collider: CollisionObject3D

func hide():
	collider.hide()
	
func show():
	collider.show()

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(collider, "QuantumObject must have a collider")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
