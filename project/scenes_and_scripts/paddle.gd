# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node2D


const BALL_SPEED_FACTOR := 1.01  # Unit: 1
const BALL_MAX_ANGLE := deg2rad(85)  # Unit: radians clockwise from north
const MAX_SPEED := 500  # Unit: px/sec
const MOUSE_CONTROL_DISABLING_ACTIONS := ["ui_left", "ui_right"]
onready var mouse_controls := false
onready var collision_rectangle: RectangleShape2D = $CollisionShape2D.shape


func half_width() -> float:
	return collision_rectangle.extents.x / 2.0


func _physics_process(delta: float) -> void:
	var max_distance_this_tic: float = MAX_SPEED * delta  # Unit: px
	if mouse_controls:
		var distance_to_mouse: float = get_local_mouse_position().x
		if abs(distance_to_mouse) <= max_distance_this_tic:
			global_position.x = get_global_mouse_position().x
		elif distance_to_mouse < 0:
			position.x -= max_distance_this_tic
		else:
			position.x += max_distance_this_tic
	else:
		position.x += Input.get_axis("ui_left", "ui_right") * max_distance_this_tic


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("enable_mouse_controls"):
		mouse_controls = true
	else:
		for action in MOUSE_CONTROL_DISABLING_ACTIONS:
			if event.is_action_pressed(action):
				mouse_controls = false
				return


func _on_Paddle_body_entered(ball: RigidBody2D) -> void:
	var distance_from_center: float = ball.position.x - position.x  # Unit: px
	# If center_ratio is -1, then the Ball hit the left edge of the Paddle.
	# If center_ratio is -0.5, then the Ball hit half-way between the left edge
	# and the center of the Paddle.
	# If center_ratio is 0, the the Ball hit the center of the Paddle.
	# If center_ratio is 0.5, then the Ball hit half-way between the center and
	# the left edge of the Paddle.
	# If center_ratio is 1, then the Ball hit the right edge of the Paddle.
	var center_ratio: float = distance_from_center / half_width()  # Unit: 1
	# This is needed because the Balls center could be beyound the Paddle’s
	center_ratio = clamp(center_ratio, -1, 1)

	var new_linear_velocity := Vector2.UP.rotated(BALL_MAX_ANGLE * center_ratio)
	new_linear_velocity *= ball.linear_velocity.length() * BALL_SPEED_FACTOR
	ball.linear_velocity = new_linear_velocity
