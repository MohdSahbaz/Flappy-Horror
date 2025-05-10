extends CanvasLayer

var high_score = 0

func load_high_score():
	if FileAccess.file_exists("user://high_score.save"):
		var file = FileAccess.open("user://high_score.save", FileAccess.READ)
		high_score = file.get_32()
		file.close()

func check_and_save_high_score():
	load_high_score()
	var current_score = $"..".send_current_score()
	$PanelContainer/CenterContainer/VBoxContainer/Score.text = "Current Score: %d" %current_score
	if current_score > high_score:
		high_score = current_score
		$PanelContainer/CenterContainer/VBoxContainer/HighScore.text = "New High Score: %d" %high_score
		var file = FileAccess.open("user://high_score.save", FileAccess.WRITE)
		file.store_32(high_score)
		file.close()
	else:
		$PanelContainer/CenterContainer/VBoxContainer/Score.text = "Current Score: %d" %current_score
		$PanelContainer/CenterContainer/VBoxContainer/HighScore.text = "High Score: %d" %high_score
