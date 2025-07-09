extends Camera3D

@export var anchor : Node3D
@export var angles : int = 6
@export var rotation_duration : float = 1.0
var angle_step : float
var target_agle : Vector3
var tween : Tween

func _ready():
	angle_step = 360.0 / angles
	target_agle = rotation

func _process(_delta):
	if (!Input.is_action_just_pressed("Camera Rotate Left") 
	&& !Input.is_action_just_pressed("Camera Rotate Right")):
		return
	
	var rotation_dir : float = Input.get_axis("Camera Rotate Right", "Camera Rotate Left")
	if (rotation_dir != 0):
		target_agle.y += rotation_dir * angle_step
		rotate_to_target()

func rotate_to_target() -> void:
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(anchor, "rotation_degrees", target_agle, rotation_duration)
