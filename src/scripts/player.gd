extends Sprite2D

var SPEED := 500.0

func _ready():
	print("hello world")
	
func _process(delta: float) -> void:
	_move_player(delta)
	frame = (frame + 1) % 4
	

## Moves the player
func _move_player(delta: float) -> void:
	if Input.is_action_pressed("up"):
		position.y -= 1 * delta * SPEED
	if Input.is_action_pressed("down"):
		position.y += 1 * delta * SPEED
	if Input.is_action_pressed("left"):
		position.x -= 1 * delta * SPEED
	if Input.is_action_pressed("right"):
		position.x += 1 * delta * SPEED
