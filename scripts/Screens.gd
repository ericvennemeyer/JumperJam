extends CanvasLayer

@onready var console = $Debug/ConsoleLog

func _ready():
	console.visible = false

func _process(delta):
	pass

func _on_texture_button_pressed():
	console.visible = !console.visible
