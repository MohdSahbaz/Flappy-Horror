extends StaticBody2D

@export var speed := 150.0

func _process(delta: float) -> void:
	position.x -= speed * delta
	if position.x < -300:
		queue_free()
