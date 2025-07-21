extends Node3D

@export var player : Node3D
@export var player_default_y = 5.004
var default_y : float

func _ready():
	assert(player, "player is not set on %s" % get_path())
	
	default_y = global_position.y

func _process(_delta):
	global_position.y = default_y
	position.z = player.global_position.y - player_default_y
