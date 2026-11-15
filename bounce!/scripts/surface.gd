extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveManager.save_game(scene_file_path)
	get_tree().get_first_node_in_group("UI").visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tp_tutorial_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/00_pit/tutorial.tscn")
