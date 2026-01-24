extends StaticBody2D

var health := 500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthBar.max_value = health
	$HealthBar.step = 1
	$HealthBar.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hurt(damage: float) -> void:
	health -= damage
	$HealthBar.value = health
	if health <= 0:
		_death()

func _death() -> void:
	var explode_scene : PackedScene = load("res://scenes/explosion.tscn")
	var explode_instance := explode_scene.instantiate() as AnimatedSprite2D
	explode_instance.play("explode2")
	explode_instance.global_position = global_position
	get_tree().root.add_child(explode_instance)
	queue_free()

func _on_tower_hit_area_area_entered(area: Area2D) -> void:
	if area is Bullet:
		var bullet := area as Bullet
		hurt(bullet.damage)
