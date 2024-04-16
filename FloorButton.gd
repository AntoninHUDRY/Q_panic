extends StaticBody3D

@onready var anim = $AnimationPlayer
@onready var area = $Area3D

var is_down = false

## Assigner une différente valeure à body.name une fois que interaction possible avec cubes

func _physics_process(delta):
	var is_down_next = area.has_overlapping_bodies()
	if is_down_next and not is_down:
		anim.play("PressDown")
		print("pressed")
	elif not is_down_next and is_down:
		anim.play("PressUp")
		print("released")
	is_down = is_down_next
