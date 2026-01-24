extends CharacterBody2D

const SPEED = 20.0
var health := 100.0
var _is_dead := false

func _ready() -> void:
	$HealthBar.max_value = health
	$HealthBar.step = 1
	$HealthBar.value = health

func _physics_process(delta: float) -> void:
	_handle_movement()
	_handle_animations()

func _handle_movement() -> void:
	if _is_dead:
		return
	velocity = (Player.Position - global_position).normalized() * SPEED
	move_and_slide()

func _handle_animations() -> void:
	if _is_dead:
		$AnimatedSprite2D.play("death")
		return
	
	var is_moving_side = abs(velocity.x) > abs(velocity.y)
	if is_moving_side:
		if velocity.x < 0:
			$AnimatedSprite2D.play("side")
			$AnimatedSprite2D.flip_h = false
		elif velocity.x > 0:
			$AnimatedSprite2D.play("side")
			$AnimatedSprite2D.flip_h = true
	else:
		if velocity.y < 0:
			$AnimatedSprite2D.play("up")
		if velocity.x > 0:
			$AnimatedSprite2D.play("down")

func hurt(damage: float) -> void:
	health -= damage
	$HealthBar.value = health
	if health <= 0:
		_death()

func _death() -> void:
	$EnemyHitArea.queue_free()
	$HealthBar.hide()
	_is_dead = true

func _on_enemy_hit_area_area_entered(area: Area2D) -> void:
	if area is Bullet:
		var bullet := area as Bullet
		hurt(bullet.damage)

func _on_animated_sprite_2d_animation_finished() -> void:
	if _is_dead:
		queue_free()
