# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node


const PaddleType: Script = preload("res://scenes_and_scripts/paddle.gd")
onready var Paddle: PaddleType = $Paddle


func _on_Pit_body_entered(body: PhysicsBody2D) -> void:
	body.queue_free()
	Paddle.call_deferred("spawn_new_ball")
