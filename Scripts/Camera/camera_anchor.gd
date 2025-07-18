extends Node3D

@export var follow : Node3D

func _ready():
	assert(follow, "follow is not set on %s" % get_path())

func _process(_delta):
	position = follow.position
