extends Node3D
var level
var step = false
var close = false
func _on_area_3d_area_entered(area):
	$Text.visible = true
	close = true


func _on_area_3d_area_exited(area):
	$Text.visible = false
	close = false
func _ready():
		level = get_node(".")

	
func _physics_process(delta):	
	if close and Input.is_action_just_pressed("interact"):
		$Subtitles1.visible = true
		Singleton.listening = true
		$Text.visible = false
		$ring.stop()
		$pickup.play()
		#-----------------------
		if level.name == "phonelv1":
			$Subtitles1/AnimationPlayer.play("audio1")
		if level.name == "phonelv2":
			$Subtitles1/AnimationPlayer.play("audio2")
		if level.name == "phonelv3":
			$Subtitles1/AnimationPlayer.play("audio3")
		if level.name == "phonelv4":
			$Subtitles1/AnimationPlayer.play("audio4")
		
	if level.name == "phonelv1":
		if $Subtitles1/AnimationPlayer.get_current_animation_position() >= 5.5 and !step:
			$Text.text="press SPACE to speak"
			$Text.visible = true
			step = true
		if step and Input.is_action_just_pressed("jump") and close:
			$Text.visible = false
			$Subtitles1/AnimationPlayer.play("audio12")
		if $Subtitles1/AnimationPlayer.get_current_animation_position() >= 59:
			Singleton.listening = false
			$Subtitles1.visible = false
#------------------------------------
		
	if level.name == "phonelv2":
		if $Subtitles1/AnimationPlayer.get_current_animation_position() >= 13 and !step:
			$Text.text="press SPACE to speak"
			$Text.visible = true
			step = true
		if step and Input.is_action_just_pressed("jump") and close:
			$Text.visible = false
			$Subtitles1/AnimationPlayer.play("audi22")
		if $Subtitles1/AnimationPlayer.get_current_animation_position() >= 20:
			Singleton.listening = false
			$Subtitles1.visible = false
	if level.name == "phonelv3":
		if $Subtitles1/AnimationPlayer.get_current_animation_position() >= 9.5:
			Singleton.listening = false
			$Subtitles1.visible = false
	if level.name == "phonelv4":
		if $Subtitles1/AnimationPlayer.get_current_animation_position() >= 32:
			Singleton.listening = false
			$Subtitles1.visible = false

func _on_timer_timeout():
	$ring.play()
