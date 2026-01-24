extends CharacterBody2D

var SPEED := 100.0

@export var _player_animations : AnimatedSprite2D
@export var _cross_hair : AnimatedSprite2D
@export var _gun : Gun
	
func _process(delta: float) -> void:
	_move_player(delta)
	_play_animations()
	_handle_cross_hair()
	_handle_gun()
	
## Moves the player
func _move_player(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	
	velocity = velocity.normalized()
	move_and_slide()
	
	position += velocity * delta * SPEED
	if velocity.length_squared() < 0.001:
		_player_animations.speed_scale = 0
	else:
		_player_animations.speed_scale = 2
		

func _play_animations() -> void:
	var dir = (get_global_mouse_position() - get_global_position()).normalized()
	
	# Decide direction by comparing axis magnitudes
	var ax : float = abs(dir.x)
	var ay : float = abs(dir.y)

	var diag_threshold := 0.1
	var is_diag := ax > diag_threshold and ay > diag_threshold

	_player_animations.flip_h = dir.x < 0

	if is_diag:
		if dir.y < 0: # north-ish
			if dir.x > 0:
				_player_animations.play("diag_up")
			else:
				_player_animations.play("diag_up")
		else: # south-ish
			if dir.x > 0:
				_player_animations.play("diag_down")
			else:
				_player_animations.play("diag_down")
	else:
		# Cardinal fallback (pick dominant axis)
		if ay >= ax:
			if dir.y < 0:
				_player_animations.play("up")
			else:
				_player_animations.play("down")
		else:
			_player_animations.play("side")

func _handle_cross_hair() -> void:
	_cross_hair.play("cross_hair_1")
	_cross_hair.global_position = get_global_mouse_position()

func _handle_gun() -> void:
	_gun.flip_h(_player_animations.flip_h)
	_gun.set_sprite(_player_animations.animation)
	
	if Input.is_action_just_pressed("shoot"):
		_gun.shoot()
