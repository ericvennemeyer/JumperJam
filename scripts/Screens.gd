extends CanvasLayer

@onready var console = $Debug/ConsoleLog
@onready var title_screen = $TitleScreen
@onready var pause_screen = $PauseScreen
@onready var game_over_screen = $GameOverScreen

var current_screen = null

func _ready():
	console.visible = false
	
	register_buttons()
	change_screen(title_screen)

func register_buttons():
	var buttons = get_tree().get_nodes_in_group("buttons")
	if buttons.size() > 0:
		for button in buttons:
			if button is ScreenButton:
				button.clicked.connect(_on_button_pressed)

func _on_button_pressed(button):
	match button.name:
		"TitlePlay":
			print("Play button is pressed")
			change_screen(pause_screen)
		"PauseRetry":
			print("Retry button is pressed")
			change_screen(game_over_screen)
		"PauseBack":
			print("Back button is pressed")
		"PauseClose":
			print("Close button is pressed")
		"GameOverBack":
			print("Game over back button is pressed")
			change_screen(title_screen)
		"GameOverRetry":
			print("Game over retry button is pressed")

func _process(delta):
	pass

func _on_texture_button_pressed():
	console.visible = !console.visible

func change_screen(new_screen):
	if current_screen:
		current_screen.disappear()
	current_screen = new_screen
	if current_screen:
		current_screen.appear()
