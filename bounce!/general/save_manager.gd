extends Node

const SAVE_PATH = "res://save_files/"
var last_scene_path: String = ""

# Called when the node enters the scene tree for the first time.
func save_game(scene_path: String) -> void:
	last_scene_path = scene_path
	var config = ConfigFile.new()
	config.set_value("Progess", "last_scene", scene_path)
	config.save(SAVE_PATH)

func load_game() -> void:
	var config = ConfigFile.new()
	var err = config.load_
	if err == OK:
		last_scene_path = config.get_value("Progress", "last_scene", "")
