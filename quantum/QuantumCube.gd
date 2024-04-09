extends QuantumObject

class_name QuantumCube


@export
var material: StandardMaterial3D

@export_group("Internal")
@export
var mesh: MeshInstance3D

var highlighted = false
@onready var outline = $RigidBody3D/MeshInstance3D/outline

func _ready():
	var surface_count = mesh.get_surface_override_material_count()
	for i in range(surface_count):
		mesh.set_surface_override_material(i, material)

func _highlight() -> void :
	highlighted = true
	outline.visible = true

func _unhighlight() -> void :
	highlighted = false
	outline.visible = false

func _on_interactable_focused(interactor):
	_highlight()


func _on_interactable_interacted(interactor):
	pass # Replace with function body.


func _on_interactable_unfocused(interactor):
	_unhighlight()
