# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node2D


export(float) var velocity_degrees: float = 1 setget set_velocity_degrees # Unit: deg/sec
var _velocity: float  # Unit: rad/sec


func set_velocity_degrees(new_velocity_degrees: float) -> void:
	velocity_degrees = new_velocity_degrees
	_update_velocity()


func _update_velocity() -> void:
	_velocity = deg2rad(velocity_degrees)


func _ready():
	_update_velocity()


func _physics_process(delta: float) -> void:
	rotate(_velocity * delta)
