extends Node2D

@export var scroll_speed = 100.0
@onready var bg1 = $Background1
@onready var bg2 = $Background2
@onready var bg3 = $Background3
@onready var bg4 = $RoadUp1
@onready var bg5 = $RoadUp2
@onready var bg6 = $RoadUp3
@onready var bg7 = $RoadDown1
@onready var bg8 = $RoadDown2
@onready var bg9 = $RoadDown3  # Fixed typo (was bg8 duplicated)

func _process(delta):
	# Move all backgrounds
	bg1.position.x -= scroll_speed * delta
	bg2.position.x -= scroll_speed * delta
	bg3.position.x -= scroll_speed * delta
	bg4.position.x -= scroll_speed * delta
	bg5.position.x -= scroll_speed * delta
	bg6.position.x -= scroll_speed * delta
	bg7.position.x -= scroll_speed * delta
	bg8.position.x -= scroll_speed * delta
	bg9.position.x -= scroll_speed * delta

	# Check and reset positions for each TRIPLE layer
	_check_and_reset_triple(bg1, bg2, bg3)  # Background layer
	_check_and_reset_triple(bg4, bg5, bg6)  # RoadUp layer
	_check_and_reset_triple(bg7, bg8, bg9)  # RoadDown layer

# New helper function for triple sprites
func _check_and_reset_triple(bg_a, bg_b, bg_c):
	if bg_a.position.x <= -bg_a.texture.get_width():
		bg_a.position.x = max(bg_b.position.x, bg_c.position.x) + bg_b.texture.get_width()
	if bg_b.position.x <= -bg_b.texture.get_width():
		bg_b.position.x = max(bg_a.position.x, bg_c.position.x) + bg_a.texture.get_width()
	if bg_c.position.x <= -bg_c.texture.get_width():
		bg_c.position.x = max(bg_a.position.x, bg_b.position.x) + bg_a.texture.get_width()
