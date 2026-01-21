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
	
	position += velocity.normalized() * delta * SPEED
	_play_animations(velocity.normalized())
	
	
func _play_animations(velocity: Vector2) -> void:
	# no movement
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	
	# diagonal
	
	
	# cardianal
	if velocity.y < 0:
		$AnimatedSprite2D.play("north")
	if velocity.y > 0:
		$AnimatedSprite2D.play("south")
	if velocity.x < 0:
		$AnimatedSprite2D.play("side")
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.play("side")
		$AnimatedSprite2D.flip_h = false
		
		
