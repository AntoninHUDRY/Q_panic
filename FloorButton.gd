extends StaticBody3D

@onready var anim = $AnimationPlayer

## Assigner une différente valeure à body.name une fois que interaction possible avec cubes

func _on_area_3d_body_entered(body):
	if body.name == "box":
		anim.play("PressDown")
		print("pressed")


func _on_area_3d_body_exited(body):
	if body.name == "box":
		anim.play("PressUp")
		print("released")
