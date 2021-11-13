# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Object


const BaseBrickType: Script = preload("res://scenes_and_scripts/bricks/base_brick.gd")
const SplitBall: PackedScene = preload("res://scenes_and_scripts/power_ups/split_ball.tscn")
var bricks_broken := 0
var bricks_until_next_powerup := 20
# The ParentOfAllLevels itself is what sets this variable
var ParentOfAllLevels: ParentOfAllLevelsType


func on_Brick_broken(brick: BaseBrickType) -> void:
	bricks_broken += 1
	if bricks_broken >= bricks_until_next_powerup:
		bricks_broken -= bricks_until_next_powerup
		bricks_until_next_powerup += 1
		var split_ball: Node = SplitBall.instance()
		call_deferred("finish_creating_power_up", split_ball, brick.global_position)


func finish_creating_power_up(power_up: Node, global_position: Vector2) -> void:
	ParentOfAllLevels.add_child(power_up)
	power_up.global_position = global_position
