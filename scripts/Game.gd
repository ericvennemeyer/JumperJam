extends Node2D

@onready var platform_parent = $PlatformParent

var camera_scene = preload("res://scenes/game_camera.tscn")
var platform_scene = preload("res://scenes/platform.tscn")

var camera = null

# Level gen variables
var viewport_size
var start_platform_y
var platform_width = 137
var y_distance_between_platforms = 100
var level_size = 50
var generated_platform_count = 0

func _ready():
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera)
	
	# Generate level
	viewport_size = get_viewport_rect().size
	generated_platform_count = 0
	start_platform_y = viewport_size.y - (y_distance_between_platforms * 2)
	generate_level(start_platform_y, true)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func create_platform(location: Vector2):
	var platform = platform_scene.instantiate()
	platform.global_position = location
	platform_parent.add_child(platform)
	return platform

func generate_level(start_y: float, generate_ground: bool):
	# Generate ground
	if generate_ground:
		var ground_layer_platform_count = (viewport_size.x / platform_width) + 1
		var ground_layer_y_offset = 62
		for i in range(ground_layer_platform_count):
			var ground_location = (Vector2(i * platform_width, viewport_size.y - ground_layer_y_offset))
			create_platform(ground_location)
	
	# Generate rest of level
	var max_x_position = viewport_size.x - platform_width
	for i in range(level_size):
		var random_x = randf_range(0.0, max_x_position)
		var location: Vector2
		location.x = random_x
		location.y = start_y - (i * y_distance_between_platforms)
		create_platform(location)
		generated_platform_count += 1
