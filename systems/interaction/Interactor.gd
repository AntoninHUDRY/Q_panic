extends Area3D

class_name Interactor

var controller: Node3D

func release(interactable: Interactable) -> void:
	interactable.released.emit(self)

func hold(interactable: Interactable) -> void:
	interactable.holded.emit(self)
	
func throw(interactable: Interactable) -> void:
	interactable.thrown.emit(self)
	
func interact(interactable: Interactable) -> void:
	interactable.interacted.emit(self)
	
func focus(interactable: Interactable) -> void:
	interactable.focused.emit(self)
	
func unfocus(interactable: Interactable) -> void:
	interactable.unfocused.emit(self)
	
func get_closest_interactable() -> Interactable:
	var list: Array[Area3D] = get_overlapping_areas()
	var distance: float
	var closest_distance: float = INF
	var closest: Interactable = null
	
	for interactable in list:
		distance = interactable.global_position.distance_to(global_position)
		
		if distance < closest_distance:
			closest = interactable as Interactable
			closest_distance = distance
			
	return closest
	


func _on_area_exited(area):
	pass # Replace with function body.
