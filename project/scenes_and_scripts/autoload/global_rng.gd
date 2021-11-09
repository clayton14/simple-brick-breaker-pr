# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node


var _rng := RandomNumberGenerator.new()


func _init() -> void:
	_rng.randomize()


func randi_range(from: int, to: int) -> int:
	return _rng.randi_range(from, to)
