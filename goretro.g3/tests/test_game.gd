# Headless checks for the parts of the game that are logic, not drawing.
#   godot --headless --path goretro.g3 --script res://tests/test_game.gd
extends SceneTree

var failures = 0

func check(condition: bool, message: String):
	if condition:
		print("ok    ", message)
	else:
		print("FAIL  ", message)
		failures += 1

func _initialize():
	# The score autoload is present because the project is loaded.
	var points = root.get_node_or_null("Points")
	check(points != null, "the Points autoload exists")
	if points == null:
		quit(1)
		return

	# A block scores once, however many times the ball touches it while it fades.
	var block = load("res://actor/blocks/block1a.tscn").instantiate()
	root.add_child(block)
	await process_frame  # let the block run _ready (its sprite is @onready)
	points.reset_current_score()
	block.hit()
	block.hit()
	block.hit()
	check(points.current_score == 10, "a block gives 10 points once (got %d)" % points.current_score)

	# The pause menu must go back to a scene that exists.
	check(ResourceLoader.exists("res://ui/title/title.tscn"), "the title scene exists")
	var pause_script = load("res://ui/pause/pause.gd").source_code
	check(pause_script.find("res://ui/title.tscn") == -1, "the pause menu does not point at a missing scene")

	quit(1 if failures > 0 else 0)
