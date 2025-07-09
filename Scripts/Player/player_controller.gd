extends CharacterBody3D

@export var speed : float = 10.0

func _process(_delta):
	var input_dir : Vector2 = Input.get_vector("Move Forward", "Move Back", "Move Right", "Move Left")
	velocity = Vector3(input_dir.x, 0.0, input_dir.y) * speed

func _physics_process(_delta):
	move_and_slide()
