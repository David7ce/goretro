extends RigidBody2D

const SPEED_RAMP_PER_BLOCK = 1.02
const MAX_SPEED_MULTIPLIER = 2.5
const PADDLE_VELOCITY_TRANSFER = 0.4
const PADDLE_MAX_BOUNCE_ANGLE_DEG = 60.0
const PADDLE_HALF_WIDTH = 45.0

@onready var ball = "."
@onready var sound_block = $sound/block
@onready var sound_wall = $sound/wall
@onready var sound_gameover = $sound/gameover

var base_speed = 0.0
var max_speed = 0.0
var current_speed = 0.0

func _ready():
	base_speed = linear_velocity.length()
	max_speed = base_speed * MAX_SPEED_MULTIPLIER
	current_speed = base_speed

func _physics_process(delta):
	for body in get_colliding_bodies():
		if body.is_in_group("block"):
			sound_block.pitch_scale = randf_range(1, 1.2)
			sound_block.play()
			body.hit()
			current_speed = min(current_speed * SPEED_RAMP_PER_BLOCK, max_speed)
		elif body.name == "player":
			var offset = clamp((global_position.x - body.global_position.x) / PADDLE_HALF_WIDTH, -1.0, 1.0)
			var angle = offset * deg_to_rad(PADDLE_MAX_BOUNCE_ANGLE_DEG)
			var base_dir = Vector2(sin(angle), -cos(angle))
			var player_push = body.velocity.x * PADDLE_VELOCITY_TRANSFER
			var new_velocity = base_dir * current_speed + Vector2(player_push, 0)
			current_speed = clamp(new_velocity.length(), base_speed, max_speed)
			linear_velocity = new_velocity.normalized() * current_speed
			sound_wall.pitch_scale = randf_range(0.8, 1.2)
			sound_wall.play()
		else:
			sound_wall.pitch_scale = randf_range(0.8, 1.2)
			sound_wall.play()

	if linear_velocity.length() > 0.0:
		linear_velocity = linear_velocity.normalized() * current_speed

func _on_visibility_screen_exited():
	sound_gameover.play()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://ui/title/title.tscn")
