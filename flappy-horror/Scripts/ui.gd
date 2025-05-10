extends  CanvasLayer

var current_score := 0
var high_score := 0

func _ready() -> void:
	add_to_group("ui")
	load_high_score()
	$Labels/HighScoreLabel.text = "High Score: %d" %high_score
	
func add_score(amount: int):
	current_score += amount
	$Labels/ScoreLabel.text = "Score: %d" % current_score
	
func load_high_score():
	if FileAccess.file_exists("user://high_score.save"):
		var file = FileAccess.open("user://high_score.save", FileAccess.READ)
		high_score = file.get_32()
		file.close()
	else:
		high_score = 0
		
func send_current_score() -> int:
	return current_score
