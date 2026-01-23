extends Node2D
class_name Gun

@export var _gun_resourse : GunResource

var _gun_positions := {
	"up": Vector2(0, -10),
	"down": Vector2(0, 10),
	"side": Vector2(10, 5),
	"diag_up": Vector2(10, -5),
	"diag_down": Vector2(10, 10),
} 

func set_sprite(anim_name: String) -> void:
	# set texture
	var texture := _gun_resourse.get_sprite(anim_name)
	$GunSprite.texture = texture
	
	# set position
	var gun_pos : Vector2 = _gun_positions[anim_name]
	$GunSprite.position = gun_pos

func flip_h(flip: bool) -> void:
	if flip:
		scale.x = -1
	else:
		scale.x = 1
	
