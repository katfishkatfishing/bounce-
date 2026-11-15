extends AnimatableBody2D

@onready var collision_shape_2d: CollisionShape2D = $Sense/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var has_triggered := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_sense_body_entered(body: CharacterBody2D) -> void:
	print("Detected a body named: ", body.name)
	if body.name == "Player":
		animation_player.play("falling_bridge")
