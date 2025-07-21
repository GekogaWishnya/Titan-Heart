extends Node3D

@export var target : Node3D
@export var animation_player : AnimationPlayer
@export var animation_speed : float = 1.0;

func _ready():
	assert(target, "target is not set on %s" % get_path())
	assert(animation_player, "animation_player is not set on %s" % get_path())
	
	animation_player.speed_scale = animation_speed
	animation_player.play("Ripple Animation")

func _on_ripple_animation_started(_anim_name):
	global_position.x = target.global_position.x
	global_position.z = target.global_position.z
