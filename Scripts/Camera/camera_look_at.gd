@tool
extends Camera3D

@export var target : Node3D

func _ready():
	assert(target, "target is not set on %s" % get_path())

func _process(_delta):
	if Engine.is_editor_hint():
		look_at(target.position)
