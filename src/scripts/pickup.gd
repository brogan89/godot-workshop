extends Area2D

@export var _resource : GunResource

@export var hover_height := 8.0
@export var duration := .8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = _resource.side
	
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "position:y", position.y - hover_height, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)


func _on_body_entered(body: Node2D) -> void:
	print("body entered: ", body.name)
	if body is not Player:
		return
		
	var player := body as Player
	player.on_pickup(_resource)
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
