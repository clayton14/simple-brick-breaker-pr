# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node2D


const MAX_SPEED := 500  # Unit: px/sec


func _physics_process(delta):
	position.x += Input.get_axis("ui_left", "ui_right") * MAX_SPEED * delta
