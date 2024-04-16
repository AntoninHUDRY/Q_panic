extends Node

class_name QuantumController

@export_group("internal")
@export
var cameras: Array[IntersectionDetectingCamera]
@export
var entangled_groups: Array[EntangledGroup]

func get_camera_collisions() -> Array[Node3D]:
	var collisions: Array[Node3D] = []
	for camera in cameras:
		if camera.visible:
			collisions.append_array(camera.get_intersections())
	return collisions

func _ready():
	print("Creating QuantumController with ", cameras.size(), " cameras and ", entangled_groups.size(), " entangled groups")

func _physics_process(_delta):
	var collisions = get_camera_collisions()
	#if len(collisions) > 0:
	#	print("Collisions: ",collisions)
	for group in entangled_groups:
		group.handle_observations(collisions)
