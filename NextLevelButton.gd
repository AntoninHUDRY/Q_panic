extends StaticBody3D

class_name NextLevelButton

@export
var next_level_path: String

@onready var anim = $AnimationPlayer
@onready var area = $Area3D

var is_down = false

## Assigner une différente valeure à body.name une fois que interaction possible avec cubes

func _ready():
	assert(next_level_path != null)

func _physics_process(delta):
	var is_down_next = area.has_overlapping_bodies()
	if is_down_next and not is_down:
		get_tree().change_scene_to_file(next_level_path)
	is_down = is_down_next
