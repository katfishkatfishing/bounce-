extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_first_node_in_group("UI").visible = true
	SaveManager.save_game(scene_file_path)
