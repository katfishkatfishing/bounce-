class_name UI
extends CanvasLayer

@onready var energy_bar: ProgressBar = $GUI/EnergyBar
@onready var hp_bar: TextureProgressBar = $GUI/MarginContainer/NinePatchRect/HPBar

const max_buildup: float = 300.0
const max_hp: int = 100

var hp: int = 100

func _ready() -> void:
	if get_tree().current_scene.name == "MainMenu":
		print("hide")
		hide()
	else:
		show()
		print("show")
	energy_bar.max_value = max_buildup
	energy_bar.value = 0.0
	energy_bar.visible = false
	
	hp_bar.max_value = max_hp
	hp_bar.min_value = 0
	hp_bar.value = hp

func update_health(new_hp: int) -> void:
	hp = new_hp
	hp_bar.value = hp
	print(hp)
