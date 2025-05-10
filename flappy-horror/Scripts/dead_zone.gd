extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var player = body
		if player.has_method("die"):
			player.die()
