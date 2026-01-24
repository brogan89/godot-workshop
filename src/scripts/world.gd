extends Node2D

@export var _enemy_scene : PackedScene
@export var spawn_points : Array

func _on_enemy_spawn_timer_timeout() -> void:
	var new_enemy := _enemy_scene.instantiate()
	add_child(new_enemy)
	
	var screen_size := get_viewport_rect().size
	var rand_x := randf_range(0.0, screen_size.x)
	var rand_y := randf_range(0.0, screen_size.y)
	
	new_enemy.global_position = Vector2(rand_x, rand_y)
