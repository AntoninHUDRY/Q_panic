extends IntersectionDetectingCamera

class_name MiniCamera

@export
var viewport: SubViewportContainer

func hide_display():
	visible = false
	viewport.visible = false

func show_display():
	visible = true
	viewport.visible = true
	
# Called when the node enters the scene tree for the first time.
func _ready():
	hide_display()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
