# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node2D


const MAX_SPEED := 500  # Unit: px/sec
const MOUSE_CONTROL_DISABLING_ACTIONS := ["ui_left", "ui_right"]
onready var mouse_controls := false


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
