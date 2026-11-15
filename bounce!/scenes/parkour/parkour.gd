extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveManager.save_game(scene_file_path)
