extends CharacterBody2D

signal player_died

@export var flap_strength := -400.0
@export var gravity := 1000.0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var is_game_over := false

func _physics_process(delta: float) -> void:
	if is_game_over == false:
		velocity.y += gravity * delta
		animation.play("walking")
		
		if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("fly"):
			$"../Tap".play()
			velocity.y = flap_strength
		
		move_and_slide()
		
		# Check collisions
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision.get_collider().is_in_group("obstacle"):
				die()

func die():
	if is_game_over:
		return
	
	$DeathSound.play()
	is_game_over = true
	animation.play("dead")
	# Stop movement immediately
	velocity = Vector2.ZERO
	# Don't pause the game yet - wait for animation to finish

# Revive
func revive():
	position = Vector2(100, 300)
	velocity = Vector2.ZERO
	is_game_over = false
	animation.play("walking")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animation.animation == "dead":
		get_tree().paused = true
		emit_signal("player_died")
