extends Node

class_name EntangledGroup

var quantum_objects: Array[QuantumObject]
var visible_object = 0
var is_in_superposition = true

func _ready():
	quantum_objects = []
	for obj in get_children():
		if obj is QuantumObject:
			quantum_objects.append(obj)
	print("Quantum objects: ", quantum_objects)
	for i in range(0, len(quantum_objects)):
		quantum_objects[i].quantum_hide()

func set_new_visible(index: int):
	print("Changing visible object from ", visible_object, " to ", index)
	quantum_objects[visible_object].quantum_hide()
	visible_object = index
	quantum_objects[visible_object].quantum_show()

# For now, simply ccolliderycle through the entangled objects that are not being observed
func handle_observations(intersections: Array[Node3D]):
	var some_object_visible = false
	
	for i in range(0, quantum_objects.size()):
		if quantum_objects[i].collider in intersections:
			some_object_visible = true
			break
	
	assert(some_object_visible == (len(intersections) != 0))
	
	if is_in_superposition and some_object_visible:
		is_in_superposition = false
		set_new_visible((randi() % (quantum_objects.size() - 1) + visible_object + 1) % quantum_objects.size() )
	elif not is_in_superposition and not some_object_visible:
		is_in_superposition = true
		for i in range(0, len(quantum_objects)):
			quantum_objects[i].quantum_hide()
	
