extends Area2D
class_name Bullet

var speed : float = 200
var direction : Vector2
var damage : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * delta * speed

func set_texture(texture: Texture) -> void:
	$Sprite2D.texture = texture

func _on_area_entered(area: Area2D) -> void:
	print("bullet hit: ", area.name)
	
	var explode_scene : PackedScene = load("res://scenes/explosion.tscn")
	var explode_instance := explode_scene.instantiate() as AnimatedSprite2D
	explode_instance.play("explode1")
	explode_instance.global_position = global_position
	get_tree().root.add_child(explode_instance)
	
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
