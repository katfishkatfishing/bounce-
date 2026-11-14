extends Node2D

@onready var player: CharacterBody2D = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass




func _on_retry_tutorial_body_entered(body: CharacterBody2D) -> void:
	print("in")
	if body.name == "player":
		body.global_position = Vector2(450, -50)





func _on_tp_parkour_body_entered(body: CharacterBody2D) -> void:
	pass # Replace with function body.
