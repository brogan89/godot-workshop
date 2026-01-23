extends Node2D

var SPEED := 100.0

func _ready():
	_play_animations(Vector2.ZERO)
	
func _process(delta: float) -> void:
	_move_player(delta)

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
	_play_animations(velocity)

func _play_animations(velocity: Vector2) -> void:
	var s := $AnimatedSprite2D

	# no movement
	if velocity.length_squared() < 0.0001:
		s.play("idle")
		return

	# Decide direction by comparing axis magnitudes
	# (works nicely even if v isn't perfectly normalized)
	var ax : float = abs(velocity.x)
	var ay : float = abs(velocity.y)

	var diag_threshold := 0.1
	var is_diag : bool = ax > diag_threshold and ay > diag_threshold

	if is_diag:
		if velocity.y < 0: # north-ish
			if velocity.x > 0:
				s.play("diag_up")   # make sure this anim exists
				s.flip_h = false
			else:
				s.play("diag_up")
				s.flip_h = true
		else: # south-ish
			if velocity.x > 0:
				s.play("diag_down")
				s.flip_h = false
			else:
				s.play("diag_down")
				s.flip_h = true
		return

	# Cardinal fallback (pick dominant axis)
	if ay >= ax:
		if velocity.y < 0:
			s.play("north")
		else:
			s.play("south")
	else:
		s.play("side")
		s.flip_h = velocity.x < 0
