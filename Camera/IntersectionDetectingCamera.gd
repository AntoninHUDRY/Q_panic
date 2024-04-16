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
	area.set_collision_layer_value(1, false)
	area.set_collision_mask_value(1, false)
	area.set_collision_mask_value(3, true)
	var collision_shape = CollisionShape3D.new()
	shape = ConvexPolygonShape3D.new()
	collision_shape.shape = shape
	area.add_child(collision_shape)
	add_child(area)

func get_intersections() -> Array[Node3D]:
	shape.points = get_pyramid_points()
	var candidates = area.get_overlapping_bodies()
	var result: Array[Node3D] = []
	for candidate in candidates:
		var owners = candidate.get_shape_owners()
		assert(len(owners) == 1)
		var owner_id = owners[0]
		var owner: CollisionShape3D = candidate.shape_owner_get_owner(owner_id)
		var found_clear_path = false
		for i in range(candidate.shape_owner_get_shape_count(owner_id)):
			if found_clear_path:
				break
			var debug_mesh = candidate.shape_owner_get_shape(owner_id, i).get_debug_mesh()
			assert(debug_mesh.get_surface_count() == 1)
			var all_verticies = debug_mesh.surface_get_arrays(0)[0]
			var unique_vectors = {}
			for vec in all_verticies:
				if vec in unique_vectors:
					continue
				var global_pos = owner.global_transform * vec
				var exclude = [candidate.get_rid()]
				if not ray_intersect(global_pos, exclude):
					found_clear_path = true
					break
				unique_vectors[vec]=true
		if found_clear_path:
			result.append(candidate)
	return result

func ray_intersect(target_pos, exclude_rids):
	var space_state = get_world_3d().direct_space_state
	var screen_center = Vector2(get_viewport().get_visible_rect().size.x / 2, get_viewport().get_visible_rect().size.y / 2)
	var from = project_ray_origin(screen_center)
	#var ray_direction = project_ray_normal(screen_center)
	#var to = from + ray_direction * SCALE_UP_FACTOR
	var collision_mask = 0b1 # Environment layer
	var query = PhysicsRayQueryParameters3D.create(from, target_pos, collision_mask, exclude_rids)
	var result = space_state.intersect_ray(query)
	if "position" in result:
		return true
	
