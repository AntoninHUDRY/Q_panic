extends StaticBody3D

var highlighted = false
var pressed = false
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not highlighted and not pressed:
		$PressMesh.mesh.material.albedo_color = Color(0 , 0, 255, 255)
	if highlighted and not pressed:
		$PressMesh.mesh.material.albedo_color = Color(255 , 0, 0, 255)
	if timer > 0:
		timer = timer - 1
	else:
		pressed = false
	pass

func _highlight() -> void :
	highlighted = true

func _unhighlight() -> void :
	highlighted = false


func _on_interactable_focused(interactor):
	_highlight()


func _on_interactable_interacted(interactor):
	$PressMesh.mesh.material.albedo_color = Color(0 , 255, 0, 255)
	pressed = true
	timer = 25


func _on_interactable_unfocused(interactor):
	_unhighlight()
