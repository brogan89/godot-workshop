extends Node2D
class_name Gun

@export var _resourse : GunResource
@export var _muzzle : Marker2D

@onready var _bullet_scene : PackedScene = preload("res://scenes/bullet.tscn")

var _shot_count := 0

var _gun_positions := {
	"up": Vector2(0, -10),
	"down": Vector2(0, 10),
	"side": Vector2(10, 5),
	"diag_up": Vector2(10, -5),
	"diag_down": Vector2(10, 10),
}

func set_sprite(anim_name: String) -> void:
	# set texture
	var texture := _resourse.get_sprite(anim_name)
	$GunSprite.texture = texture
	
	# set position
	var gun_pos : Vector2 = _gun_positions[anim_name]
	$GunSprite.position = gun_pos

func flip_h(flip: bool) -> void:
	if flip:
		scale.x = -1
	else:
		scale.x = 1

func shoot() -> void:
	var bullet : Bullet = _bullet_scene.instantiate()
	bullet.name = "Bullet_" + str(_shot_count)
	get_tree().root.add_child(bullet)
	bullet.set_texture(_resourse.bullet)
	bullet.global_position = _muzzle.global_position
	bullet.direction = (get_global_mouse_position() - _muzzle.global_position).normalized()
	_shot_count += 1
