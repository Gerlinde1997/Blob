extends Node

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

var current_scene = null


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# remove current scene
	current_scene.free()
	
	# load new scene
	var s = ResourceLoader.load(path)
	# instance new scene
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
