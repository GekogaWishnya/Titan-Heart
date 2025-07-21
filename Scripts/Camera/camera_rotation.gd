extends Camera3D

@export var anchor : Node3D
@export var angles : int = 6
@export var rotation_duration : float = 1.0
var angle_step : float
var target_agle : Vector3
var tween : Tween

func _ready():
	assert(anchor, "anchor is not set on %s" % get_path())
	
	angle_step = deg_to_rad(360.0 / angles)
	target_agle.y = deg_to_rad(anchor.rotation_degrees.y)

func _process(_delta):
	var rotation_dir =  0.0
	
	if (Input.is_action_just_pressed("Camera Rotate Left")):
		rotation_dir = 1.0
	elif (Input.is_action_just_pressed("Camera Rotate Right")):
		rotation_dir = -1.0
		
	if (rotation_dir != 0):
		target_agle.y += rotation_dir * angle_step
		rotate_to_target()

func rotate_to_target() -> void:
	if tween:
		tween.kill()
	
	var quat_target : Quaternion = Quaternion.from_euler(target_agle)
	tween = create_tween()
	tween.tween_property(anchor, "quaternion", quat_target, rotation_duration)
