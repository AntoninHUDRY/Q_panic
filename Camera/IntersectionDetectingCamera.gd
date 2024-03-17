extends Camera3D

class_name IntersectionDetectingCamera

@export
var pyramid_scale_factor = 10000.

var area: Area3D
var shape: ConvexPolygonShape3D

func get_pyramid_points() -> Array[Vector3]:
	var pyramid_rid = get_pyramid_shape_rid()
	var pyramid_points = PhysicsServer3D.shape_get_data(pyramid_rid)

	var pyramid_points_scaled: Array[Vector3] = []
	for x in pyramid_points:
		pyramid_points_scaled.append(x*pyramid_scale_factor)
	
	return pyramid_points_scaled

func _init():
	area = Area3D.new()
	var collision_shape = CollisionShape3D.new()
	shape = ConvexPolygonShape3D.new()
	collision_shape.shape = shape
	area.add_child(collision_shape)
	add_child(area)

func get_intersections() -> Array[Node3D]:
	shape.points = get_pyramid_points()
	return area.get_overlapping_bodies()
