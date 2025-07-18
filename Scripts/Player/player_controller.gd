extends CharacterBody3D

@export var speed : float = 20.0
@export var camera_anchor : Node3D;

func _ready():
	assert(camera_anchor, "camera_anchor is not set on %s" % get_path())

func _process(_delta):
	var input_dir : Vector2 = Input.get_vector("Move Forward", "Move Back", "Move Right", "Move Left")
	var movement_dir = input_dir.x * camera_anchor.basis.x + input_dir.y * camera_anchor.basis.z;
	velocity = movement_dir * speed

func _physics_process(_delta):
	move_and_slide()
