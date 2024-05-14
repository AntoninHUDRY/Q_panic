extends Area3D


class_name Interactable

# Emitted when Interactor starts looking at me
signal focused(interactor: Interactor)
# Emitted when Interactor stops looking at me
signal unfocused(interactor: Interactor)
# Emitted when Interactor interacts with me
signal interacted(interactor: Interactor)
# Emitted when Interactor holds me
signal holded(interactor: Interactor)
# Emitted when interactor throws me
signal thrown (interactor: Interactor)
# Emitted when Interactor releases me
signal released(interactor: Interactor)

func _on_focused(interactor):
	pass # Replace with function body.


func _on_interacted(interactor):
	pass # Replace with function body.

func _on_holded(interactor):
	pass

func _on_released(interactor):
	pass

func _on_unfocused(interactor):
	pass # Replace with function body.

