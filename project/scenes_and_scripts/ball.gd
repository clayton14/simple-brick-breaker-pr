# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends RigidBody2D


const MIN_Y_SPEED := 10  # Unit: px/sec


# When this Ball collides with anything other than the Paddle
func _on_Ball_body_entered(_body: PhysicsBody2D) -> void:
	if linear_velocity.y <= 0:
		if linear_velocity.y > -MIN_Y_SPEED:
			# The Ball is traveling upwards and isn’t fast enough.
			apply_central_impulse(Vector2(0, -MIN_Y_SPEED))
	elif linear_velocity.y < MIN_Y_SPEED:
		# The Ball is traveling downwards and isn’t fast enough.
		apply_central_impulse(Vector2(0, MIN_Y_SPEED))
