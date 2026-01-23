extends Node2D

var SPEED := 100.0

@export var _player_animations : AnimatedSprite2D
@export var _cross_hair : AnimatedSprite2D

func _ready():
	_play_animations()
	
func _process(delta: float) -> void:
	_move_player(delta)
	_play_animations()
	_handle_cross_hair()
	
## Moves the player
func _move_player(delta: float) -> void:
	var velocity : Vector2
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	
	velocity = velocity.normalized()
	position += velocity * delta * SPEED

func _play_animations() -> void:
	var dir = get_global_mouse_position() - self.get_global_position()
	var velocity := dir.normalized();
	
	# Decide direction by comparing axis magnitudes
	var ax : float = abs(velocity.x)
	var ay : float = abs(velocity.y)

	var diag_threshold := 0.1
	var is_diag := ax > diag_threshold and ay > diag_threshold

	_player_animations.flip_h = velocity.x < 0

	if is_diag:
		if velocity.y < 0: # north-ish
			if velocity.x > 0:
				_player_animations.play("diag_up")
			else:
				_player_animations.play("diag_up")
		else: # south-ish
			if velocity.x > 0:
				_player_animations.play("diag_down")
			else:
				_player_animations.play("diag_down")
	else:
		# Cardinal fallback (pick dominant axis)
		if ay >= ax:
			if velocity.y < 0:
				_player_animations.play("north")
			else:
				_player_animations.play("south")
		else:
			_player_animations.play("side")

func _handle_cross_hair() -> void:
	_cross_hair.play("cross_hair_1")
	_cross_hair.global_position = get_global_mouse_position()
