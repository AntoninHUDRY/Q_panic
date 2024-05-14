extends Interactor

@export var player: CharacterBody3D

var cached_closest: Interactable

@onready var hand = $Hand
var picked_object = null

func _ready() -> void:
	controller = player

func _physics_process(_delta: float) -> void:
	var new_closest: Interactable = get_closest_interactable()
	if new_closest != cached_closest:
		if is_instance_valid(cached_closest):
			unfocus(cached_closest)
		if new_closest:
			focus(new_closest)
		
		cached_closest = new_closest
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if cached_closest:
			interact(cached_closest)
	if event.is_action_pressed("throw"):
		if cached_closest:
			throw(cached_closest)
			picked_object = null
	if event.is_action_pressed("hold") and picked_object == null:
		if cached_closest:
			picked_object = cached_closest
			hold(picked_object)
	if event.is_action_pressed("release") and picked_object != null:
		release(picked_object)
		picked_object = null
			
func _on_area_exited(area: Interactable) -> void:
	if cached_closest == area:
		unfocus(area)
