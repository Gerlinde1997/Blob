extends Camera2D

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
