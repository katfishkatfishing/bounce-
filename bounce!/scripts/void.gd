extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	await get_tree().process_frame


func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		body.in_void = true
		print("void consumes")
		GameManager.die_respawn()
