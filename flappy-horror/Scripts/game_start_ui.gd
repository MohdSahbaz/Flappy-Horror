extends CanvasLayer

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		start_game()
		
func start_game():
	$".".visible = false
	$"../Labels/ScoreLabel".visible = true
	$"../Labels/HighScoreLabel".visible = true
	get_tree().paused = false
	queue_free()
