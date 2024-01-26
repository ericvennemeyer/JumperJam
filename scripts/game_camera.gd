extends Camera2D

var player: Player = null
var viewport_size

func _ready():
	viewport_size = get_viewport_rect().size
	global_position.x = viewport_size.x / 2
	
	limit_bottom = viewport_size.y
	limit_left = 0
	limit_right = viewport_size.x

func _process(delta):
	if player:
		if limit_bottom > player.global_position.y + (viewport_size.y / 2):
			limit_bottom = player.global_position.y + (viewport_size.y / 2)

func _physics_process(delta):
	if player:
		global_position.y = player.global_position.y

func setup_camera(_player: Player):
	if _player:
		player = _player
