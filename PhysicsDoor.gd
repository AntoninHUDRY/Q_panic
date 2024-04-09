extends RigidBody3D


var is_open = false

func close() -> void:
	is_open = false
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", Vector3.ZERO, 0.3).set_ease(Tween.EASE_OUT)

func open_inward() -> void:
	_open_to_rotation(90)

func open_outward() -> void:
	_open_to_rotation(-90)

func open_away_from(opener_position: Vector3) -> void:
	is_open = true
	var direction: Vector3 = global_position.direction_to(opener_position)
	var forward_vector: Vector3 = Vector3.RIGHT.rotated(Vector3.UP, global_rotation.y)
	var angle: float = direction.dot(forward_vector)

	if angle > 0:
		open_inward()
	else:
		open_outward()

func _open_to_rotation(to_rotation: float = 90) -> void:
	is_open = true
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", Vector3(0, to_rotation, 0), 0.3).set_ease(Tween.EASE_OUT)
	
	

func _on_interactable_focused(interactor):
	pass # Replace with function body.


func _on_interactable_interacted(interactor) -> void:
	if is_open:
		close()
	else:
		open_away_from(interactor.position)


func _on_interactable_unfocused(interactor):
	pass # Replace with function body.
