extends QuantumObject

class_name QuantumCube


@export
var material: StandardMaterial3D

@export_group("Internal")
@export
var mesh: MeshInstance3D

func _ready():
	var surface_count = mesh.get_surface_override_material_count()
	for i in range(surface_count):
		mesh.set_surface_override_material(i, material)
