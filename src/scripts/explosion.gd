extends AnimatedSprite2D

func _ready() -> void:
	$AudioStreamPlayer2D.play()

func _on_animation_finished() -> void:
	queue_free()
