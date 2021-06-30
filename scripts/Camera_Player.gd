extends Camera2D

## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

onready var tilemap = $"../../Map/Ground"


func _ready():
	set_camera_limits()


func set_camera_limits():
	var scope = tilemap.get_used_rect()
	var cellsize = tilemap.cell_size
	
	limit_left = scope.position.x * cellsize.x
	limit_right = scope.end.x * cellsize.x
	limit_top = scope.position.y * cellsize.y
	limit_bottom = scope.end.y * cellsize.y
