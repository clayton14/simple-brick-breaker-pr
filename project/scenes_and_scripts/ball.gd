# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends RigidBody2D


const NORMAL_COLLISION_LAYER := 1
const NORMAL_COLLISION_MASK := 2
const MIN_Y_SPEED := 10  # Unit: px/sec
var old_linear_velocity: Vector2


func radius() -> float:
	return $CollisionShape2D.shape.radius


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
