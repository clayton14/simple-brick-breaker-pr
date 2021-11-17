# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node2D


const COLORS: Array = [
		Color("FF0000"),
		Color("FFA500"),
		Color("FFFF00"),
		Color("008000"),
		Color("00FFFF"),
		Color("0099FF"),
		Color("9900FF")
]
export(int, 0, 6) var color_index := 0


func update_color() -> void:
	modulate = COLORS[color_index]


func _ready() -> void:
	update_color()


func _on_Timer_timeout() -> void:
	color_index = (color_index + 1) % len(COLORS)
	update_color()
