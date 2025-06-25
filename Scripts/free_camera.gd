extends Camera3D

@export var speed = 400

func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position.x += direction.x * speed * delta
	position.z += direction.y * speed * delta
