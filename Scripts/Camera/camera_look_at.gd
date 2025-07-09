@tool
extends Camera3D

@export var target : Node3D

func _process(_delta):
	if Engine.is_editor_hint():
		look_at(target.position)
