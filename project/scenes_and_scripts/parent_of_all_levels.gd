# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node
class_name ParentOfAllLevelsType


const BaseLevel: Script = preload("res://scenes_and_scripts/levels/base_level.gd")
const PaddleType: Script = preload("res://scenes_and_scripts/paddle.gd")
onready var Paddle: PaddleType = $Paddle
onready var current_level: Node


func switch_to_level(new_level: PackedScene) -> void:
	current_level.queue_free()
	_start_level(new_level)


func _start_level(new_level: PackedScene) -> void:
	current_level = new_level.instance()
	# The new level will contain physics objects, so we need to use
	# call_deferred to prevent errors.
	call_deferred("add_child", current_level)


func _ready():
	get_node("/root/StatCounter").ParentOfAllLevels = self
	_start_level(preload("res://scenes_and_scripts/levels/level_1.tscn"))


func _on_Pit_body_entered(body: PhysicsBody2D) -> void:
	body.queue_free()

	# If the body is a Ball and its the last Ball
	if body is BallType and len(get_tree().get_nodes_in_group("Balls")) == 1:
		Paddle.call_deferred("spawn_new_ball")
	if Paddle.all_bricks_cleared():
		var error_code = body.connect(
				"tree_exited",
				Paddle,
				"check_if_level_is_over",
				[],
				CONNECT_ONESHOT
		)
		if error_code != OK:
			push_error(
					"Can’t check if the Ball that just fell out the bottom was "
					+ "the last one. The player may have to release all of the "
					+ "balls and recatch them to start the next level."
			)


func _on_Paddle_level_finished_balls_caught():
	switch_to_level(load(current_level.next_level_path))
