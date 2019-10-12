extends Node

signal start_game

var current_screen = null

func _ready() -> void:
	register_buttons()
	changue_screen($TitleScreen)
	
func register_buttons():
	var buttons = get_tree().get_nodes_in_group("buttons")
	for button in buttons:
		button.connect("pressed", self, "_on_button_pressed", [button.name])

func _on_button_pressed(name):
	match name:
		"Home":
			changue_screen($TitleScreen)
		"Play":
			changue_screen(null)
			yield(get_tree().create_timer(0.5), "timeout")
			emit_signal("start_game")
		"Settings":
			changue_screen($SettingsScreen)
			
func changue_screen(new_screen):
	if current_screen:
		current_screen.disappear()
		yield(current_screen.tween, "tween_completed")
	current_screen = new_screen
	if new_screen:
		current_screen.appear()
		yield(current_screen.tween, "tween_completed")
		
func game_over():
	changue_screen($GameOverScreen)
