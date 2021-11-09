# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node


const BaseBrick: Script = preload("res://scenes_and_scripts/bricks/base_brick.gd")
const GlobalRNGType: Script = preload("res://scenes_and_scripts/autoload/global_rng.gd")
const PaddleType: Script = preload("res://scenes_and_scripts/paddle.gd")
var bricks: Array
onready var GlobalRNG: GlobalRNGType = get_node("/root/GlobalRNG")
onready var Timer: Timer = $Timer
onready var Paddle: PaddleType = $Paddle


func _on_Goal_body_entered(_body: PhysicsBody2D) -> void:
	bricks = get_tree().get_nodes_in_group("Bricks")
	$Timer.start()


func _on_Timer_timeout() -> void:
	while not bricks.empty():
		var i: int = GlobalRNG.randi_range(0, len(bricks) - 1)
		var brick: BaseBrick = bricks.pop_at(i)
		if is_instance_valid(brick):
			Timer.wait_time *= 0.75
			brick.fall()
			return
	Timer.stop()


func _on_Pit_body_entered(body: PhysicsBody2D) -> void:
	body.queue_free()
	Paddle.call_deferred("spawn_new_ball")
