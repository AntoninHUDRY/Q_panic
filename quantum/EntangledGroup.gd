extends Node

class_name EntangledGroup

var quantum_objects: Array[QuantumObject]
var visible_object = 0
var has_visible_been_seen = false

func _ready():
	quantum_objects = []
	for obj in get_children():
		if obj is QuantumObject:
			quantum_objects.append(obj)
	print("Quantum objects: ", quantum_objects)
	for i in range(1, len(quantum_objects)):
		quantum_objects[i].quantum_hide()

func set_new_visible(index: int):
	print("Changing visible object from ", visible_object, " to ", index)
	quantum_objects[visible_object].quantum_hide()
	visible_object = index
	has_visible_been_seen = false
	quantum_objects[visible_object].quantum_show()

# For now, simply ccolliderycle through the entangled objects that are not being observed
func handle_observations(intersections: Array[Node3D]):
	if quantum_objects[visible_object].collider in intersections:
		has_visible_been_seen = true
		return
	
	if not has_visible_been_seen:
		return

	for i in range(1, quantum_objects.size()):
		var index = (i + visible_object) % quantum_objects.size()
		if quantum_objects[index].collider not in intersections:
			set_new_visible(index)
			break
	
