# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends RigidBody2D
class_name BallType


const NORMAL_COLLISION_LAYER := 1
const NORMAL_COLLISION_MASK := 2
const MIN_Y_SPEED := 10  # Unit: px/sec
const SPLIT_ROTATION: float = deg2rad(30)  # Unit: radians
var old_linear_velocity: Vector2
onready var Ball: PackedScene = load("res://scenes_and_scripts/ball.tscn")


func radius() -> float:
	return $CollisionShape2D.shape.radius


func split() -> void:
	var new_ball: BallType = Ball.instance()
	new_ball.position = position
	var base_lv: Vector2

	var being_held: bool = is_being_held()
	if being_held:
		base_lv = old_linear_velocity
	else:
		base_lv = linear_velocity
	new_ball.linear_velocity = base_lv.rotated(-SPLIT_ROTATION)
	var parent: Node = get_parent()
	if is_being_held():
		parent.grab_ball(new_ball)
	else:
		parent.add_child(new_ball)
	set_deferred("linear_velocity", linear_velocity.rotated(SPLIT_ROTATION))


func is_being_held() -> bool:
	return mode == MODE_KINEMATIC


func start_being_held() -> void:
	old_linear_velocity = linear_velocity
	mode = MODE_KINEMATIC
	layers = 0


func stop_being_held() -> void:
	mode = MODE_RIGID
	collision_layer = NORMAL_COLLISION_LAYER
	collision_mask = NORMAL_COLLISION_MASK
	linear_velocity = old_linear_velocity


# When this Ball collides with anything other than the Paddle
func _on_Ball_body_entered(_body: PhysicsBody2D) -> void:
	if linear_velocity.y <= 0:
		if linear_velocity.y > -MIN_Y_SPEED:
			# The Ball is traveling upwards and isn’t fast enough.
			apply_central_impulse(Vector2(0, -MIN_Y_SPEED))
	elif linear_velocity.y < MIN_Y_SPEED:
		# The Ball is traveling downwards and isn’t fast enough.
		apply_central_impulse(Vector2(0, MIN_Y_SPEED))
