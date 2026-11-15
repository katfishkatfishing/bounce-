extends CanvasLayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		toggle_pause()


func toggle_pause() -> void:
	var new_pause_state := not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_quit_game_button_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()

func _on_continue_game_button_pressed() -> void:
	toggle_pause()
