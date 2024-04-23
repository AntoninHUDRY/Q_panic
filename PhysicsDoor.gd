extends RigidBody3D

class_name PhysicsDoor

var is_locked = true
var is_open = false
var highlighted = false
@onready var outline = $MeshInstance3D/outline

func _physics_process(delta):
	pass
	
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

func unlock():
	is_locked = false
	
func lock():
	if is_open:
		close()
	is_locked = true

func _open_to_rotation(to_rotation: float) -> void:
	is_open = true
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", Vector3(0, to_rotation, 0), 0.3).set_ease(Tween.EASE_OUT)
	#tween.tween_property(collision, "rotation_degrees", Vector3(0, to_rotation, 0), 0.3).set_ease(Tween.EASE_OUT)
	
	
func _highlight() -> void :
	highlighted = true
	outline.visible = true

func _unhighlight() -> void :
	highlighted = false
	outline.visible = false

func _on_interactable_focused(interactor) -> void:
	_highlight()


func _on_interactable_interacted(interactor) -> void:
	print("Interacting with door. is_locked: "+str(is_locked) + " is_open: "+ str(is_open))
	if not is_locked:
		if is_open:
			close()
		else:
			open_away_from(interactor.position)


func _on_interactable_unfocused(interactor) -> void:
	_unhighlight()


func _on_interactable_holded(interactor):
	pass # Replace with function body.


func _on_interactable_released(interactor):
	pass # Replace with function body.
