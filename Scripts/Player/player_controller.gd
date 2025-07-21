extends CharacterBody3D

@export var speed : float = 20.0
@export var camera_anchor : Node3D;

func _ready():
	assert(camera_anchor, "camera_anchor is not set on %s" % get_path())

func _process(_delta):
	var input_dir : Vector2 = Input.get_vector("Move Forward", "Move Back", "Move Left", "Move Right")
	var movement_dir = input_dir.x * camera_anchor.basis.z + input_dir.y * camera_anchor.basis.x;
	velocity = movement_dir * speed
	
	if not is_on_floor():
		velocity.y = get_gravity().y

func _physics_process(_delta):
	move_and_slide()
