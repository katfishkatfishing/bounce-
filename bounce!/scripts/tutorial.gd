extends Node2D

@onready var player: CharacterBody2D = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_first_node_in_group("UI").visible = true
	SaveManager.save_game(scene_file_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass




func _on_retry_tutorial_body_entered(body: Node2D) -> void:
	print("in")
	if body.name == "Player":
		body.global_position = Vector2(450, -50)



func _on_tp_parkour_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/parkour/parkour.tscn")
