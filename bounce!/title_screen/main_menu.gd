extends CanvasLayer

@onready var load_game_button: Button = $UIContainer/VBoxContainer/LoadGameButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene.name == "MainMenu":
		hide()
	else:
		show()
		
	if SaveManager.last_scene_path == "" or not ResourceLoader.exists(SaveManager.last_scene_path):
		load_game_button.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/surface/surface.tscn")
	GameManager.die_respawn()

func _on_load_game_button_pressed() -> void:
	if SaveManager.last_scene_path != "":
		get_tree().change_scene_to_file(SaveManager.last_scene_path)
