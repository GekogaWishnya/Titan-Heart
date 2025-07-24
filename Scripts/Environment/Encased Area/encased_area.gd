extends Area3D

@export var collision : CollisionShape3D
@export var tp_margin : float = 10.0
var collision_box : BoxShape3D

func _ready():
	assert(collision, "collision is not set on %s" % get_path())
	if (collision.shape is BoxShape3D):
		collision_box = collision.shape
	else:
		push_error("collision shape is not set to BoxShape3D on %s" % get_path())

func _on_body_exited(body : Node3D) -> void:
	var distance = Vector3(
		(position.x - body.position.x), 
		0.0,
		(position.z - body.position.z)
	)
	
	if (abs(distance.x) >= collision_box.size.x / 2.0):
		body.position.x = position.x + distance.x - (tp_margin if distance.x >= 0 else -tp_margin);
	
	if (abs(distance.z) >= collision_box.size.z / 2.0):
		body.position.z = position.z + distance.z - (tp_margin if distance.x >= 0 else -tp_margin);
