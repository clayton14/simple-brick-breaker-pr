# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends RigidBody2D


signal broken
const GlobalRNGType: Script = preload("res://scenes_and_scripts/autoload/global_rng.gd")
const FALL_COLLISION_LAYER: int  = 4
export(bool) var random_color_variation := false
export(float) var value_max := 1.0
export(float) var value_min := 60.0/255.0


func _ready() -> void:
	if random_color_variation:
		var GlobalRNG: GlobalRNGType = get_node("/root/GlobalRNG")
		modulate.v = GlobalRNG.randf_range(value_min, value_max)
	var StatCounter = get_node("/root/StatCounter")
	var error_code: int = connect("broken", StatCounter, "on_Brick_broken", [self])
	if error_code != OK:
		push_error(
				"Couldn’t connect the “broken” signal to StatCounter. This "
				+ "brick won’t be counted and can never drop power-ups."
		)


func fall() -> void:
	contact_monitor = false
	layers = FALL_COLLISION_LAYER
	mode = MODE_RIGID


func _on_Brick_body_entered(_body: Node) -> void:
	emit_signal("broken")
	queue_free()
