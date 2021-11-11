# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node


const BallType: Script = preload("res://scenes_and_scripts/ball.gd")
const PaddleType: Script = preload("res://scenes_and_scripts/paddle.gd")
onready var Paddle: PaddleType = $Paddle
onready var current_level: Node


func switch_to_level(new_level: PackedScene) -> void:
	current_level = new_level.instance()
	# The new level will contain physics objects, so we need to use
	# call_deferred to prevent errors.
	call_deferred("add_child", current_level)


func _ready():
	switch_to_level(preload("res://scenes_and_scripts/levels/level_1.tscn"))


func _on_Pit_body_entered(body: PhysicsBody2D) -> void:
	body.queue_free()

	if body is BallType:
		Paddle.call_deferred("spawn_new_ball")


func _on_Paddle_level_finished_ball_caught():
	switch_to_level(preload("res://scenes_and_scripts/levels/level_2.tscn"))
