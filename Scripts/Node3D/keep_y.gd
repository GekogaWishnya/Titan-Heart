extends Node3D

var y : float;

func _ready():
	y = global_position.y

func _process(_delta):
	global_position.y = y
