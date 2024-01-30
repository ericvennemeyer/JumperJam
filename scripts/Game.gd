extends Node2D

@onready var level_generator = $LevelGenerator
@onready var ground_sprite = $GroundSprite

var camera_scene = preload("res://scenes/game_camera.tscn")
var player_scene = preload("res://scenes/player.tscn")
var player_spawn_pos: Vector2
var player_spawn_pos_y_offset = 135

var camera = null
var player: Player = null

func _ready():
	var viewport_size = get_viewport_rect().size
	player_spawn_pos.x = viewport_size.x / 2.0
	player_spawn_pos.y = viewport_size.y - player_spawn_pos_y_offset
	
	ground_sprite.global_position.x = viewport_size.x / 2.0
	ground_sprite.global_position.y = viewport_size.y
	
	new_game()

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func new_game():
	player = player_scene.instantiate()
	player.global_position = player_spawn_pos
	add_child(player)
	
	camera = camera_scene.instantiate()
	camera.setup_camera(player)
	add_child(camera)
	
	if player:
		level_generator.setup(player)
