extends Node3D

class_name Door

@export
var buttons: Array[FloorButton] = []

@onready
var doorColloder: PhysicsDoor = $PhysicsDoor

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for button in buttons:
		if not button.is_down:
			doorColloder.lock()
			return
	doorColloder.unlock()
	
