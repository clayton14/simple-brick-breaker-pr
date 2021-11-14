# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends "res://scenes_and_scripts/bricks/base_brick.gd"


const GlobalRNGType: Script = preload("res://scenes_and_scripts/autoload/global_rng.gd")

func _ready():
	var GlobalRNG: GlobalRNGType = get_node("/root/GlobalRNG")
	modulate.v = GlobalRNG.randf_range(60.0/255.0, 1.0)
