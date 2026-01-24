extends Area2D
class_name Bullet

var direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * delta * 100

func set_texture(texture: Texture) -> void:
	$Sprite2D.texture = texture

func _on_area_entered(area: Area2D) -> void:
	print("bullet hit: ", area.name)
	queue_free()
