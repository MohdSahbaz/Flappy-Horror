extends Area2D

@export var Speed := 150.0
@onready var animated_soul: AnimatedSprite2D = $AnimatedSprite2D

var soul_destroy := false

func _process(delta: float) -> void:
	position.x -= Speed * delta

func _on_body_entered(body):
	if body.name == "Player":
		animated_soul.play("destroy")
		$CollectSoulSound.play()
		get_tree().call_group("ui", "add_score", 1)
		$CollisionShape2D.visible = false
		soul_destroy = true

func _on_animated_sprite_2d_animation_finished() -> void:
	if soul_destroy and animated_soul.animation == "destroy":
		queue_free()
