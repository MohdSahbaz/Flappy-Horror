extends Node2D

# Obsticals
@onready var ObstacleScene = preload("res://Scenes/Obstacle.tscn")
var screen_size: Vector2i
var obstacle_delay := 100
var obstacle_range := 200
var obstacles : Array
var last_obstacle_y := 0.0

# Souls
@onready var SoulScene = preload("res://Scenes/soul.tscn")
var ground_height := 100  # Estimate if not exact
var soul_margin := 100  # How far from top/bottom to avoid screen edge
var obstacle_gap_top := 300
var obstacle_gap_bottom := 500  # Adjust based on how your obstacle gap is defined
var gap_size := 200.0  # The vertical gap between top and bottom obstacle

# Continue
var has_used_continue := false

func _ready() -> void:
	screen_size = get_window().size
	randomize()
	get_tree().paused = true
	generate_obstacles()
	$Player.connect("player_died", Callable(self, "_on_player_died"))

# Obsticals
func generate_obstacles():
	var obstacle = ObstacleScene.instantiate()
	obstacle.position.x = screen_size.x + obstacle_delay

	var top_margin = 100
	var bottom_margin = 200
	var min_y = top_margin
	var max_y = screen_size.y - bottom_margin
	obstacle.position.y = randf_range(min_y, max_y)

	add_child(obstacle)
	obstacles.append(obstacle)

	# Store Y position for soul spawn logic
	last_obstacle_y = obstacle.position.y

func _on_obstacle_timer_timeout() -> void:
	generate_obstacles()
	
	# Souls
func spawn_soul():
	var soul = SoulScene.instantiate()
	soul.position.x = screen_size.x + 100

	var spawn_y := 0.0
	while true:
		spawn_y = randf_range(soul_margin, screen_size.y - ground_height - soul_margin)
		if abs(spawn_y - last_obstacle_y) > gap_size / 2:
			break  # This Y is safely outside the gap

	soul.position.y = spawn_y
	add_child(soul)

func _on_soul_timer_timeout() -> void:
	spawn_soul()
	$SoulTimer.wait_time = randf_range(1.5, 3.0)
	$SoulTimer.start()

# Player death
func _on_player_died():
	game_over()

# Game Over
func game_over():
	$UI/GameOverUI.check_and_save_high_score()
	if has_used_continue == true:
		$UI/GameOverUI/PanelContainer/CenterContainer/VBoxContainer/HBoxContainer/Continue.visible = false
	$Player.is_game_over = true
	$UI/GameOverUI.visible = true
	get_tree().paused = true

func _on_restart_pressed() -> void:
	get_tree().paused = false
	$Player.is_game_over = false
	get_tree().reload_current_scene()

func _on_continue_pressed() -> void:
	if has_used_continue:
		return
	$Player.is_game_over = false
	has_used_continue = true
	$UI/GameOverUI.visible = false
	get_tree().paused = false
	$Player.revive()
