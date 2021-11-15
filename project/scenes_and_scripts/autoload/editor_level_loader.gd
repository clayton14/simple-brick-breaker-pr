# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
# SPDX-FileType: SOURCE
extends Node


var tree: SceneTree


func level_from_editor_fail() -> void:
	push_warning(
			"If you’re trying to run a level from the editor, then it won’t "
			+ "have a Ball and Paddle."
	)
	queue_free()


func _enter_tree() -> void:
	if OS.is_debug_build():
		tree = get_tree()
		if tree.connect("node_added", self, "_check_for_first_scene_load") != OK:
			level_from_editor_fail()
	else:
		queue_free()


func _check_for_first_scene_load(node: Node) -> void:
	if node == tree.current_scene:
		if node.filename.begins_with("res://scenes_and_scripts/levels/"):
			var error_code: int = tree.change_scene_to(
					load("res://scenes_and_scripts/parent_of_all_levels.tscn")
			)
			if error_code == OK:
				tree.disconnect("node_added", self, "_check_for_first_scene_load")
				error_code = tree.connect(
						"node_added",
						self,
						"_check_for_scene_changed_to_ParentOfAllLevls",
						[load(node.filename)]
				)
			if error_code != OK:
				level_from_editor_fail()


func _check_for_scene_changed_to_ParentOfAllLevls(
		node: Node,
		level: PackedScene
) -> void:
	if node == tree.current_scene:
		var error_code: int = node.connect(
				"ready",
				self,
				"_on_ParentOfAllLevels_ready",
				[node, level]
		)
		if error_code != OK:
			push_warning(
					"Failed to detect when ParentOfAllLevels is ready. The game "
					+ "will start at Level1."
			)
			queue_free()


func _on_ParentOfAllLevels_ready(
		parent_of_all_levels: ParentOfAllLevelsType,
		level: PackedScene
) -> void:
	parent_of_all_levels.switch_to_level(level)
	queue_free()
