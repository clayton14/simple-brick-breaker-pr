# SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
# SPDX-FileContributor: Jason Yundt <jason@jasonyundt.email> (2022)
extends Node


const FIRST_SCENE_PATH := "res://scenes_and_scripts/parent_of_all_levels.tscn"
const URL := "https://jasonyundt.website/submitting-patches.html"


func _handle_potential_error(fail_message: String, error_code: int) -> void:
	if error_code != OK:
		var message := "%s Error code: %s." % [fail_message, error_code]
		push_error(message)

		var label: RichTextLabel = $RichTextLabel
		label.bbcode_enabled = false
		label.text = message


func _on_Button_pressed() -> void:
	var tree: SceneTree = get_tree()
	var error_code: int = tree.change_scene(FIRST_SCENE_PATH)
	var fail_message := "Failed to change scene to “%s”." % [FIRST_SCENE_PATH]
	_handle_potential_error(fail_message, error_code)


func _on_RichTextLabel_meta_clicked(_meta) -> void:
	var error_code: int = OS.shell_open(URL)
	var fail_message := "Failed to open <%s>." % [URL]
	_handle_potential_error(fail_message, error_code)
