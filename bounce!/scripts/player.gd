extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coyote_time: float = 0.2

var coyote_timer: float = 0.0

#region
const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const fall_velocity: float = 100.0
const max_fall_velocity: float = 100.0
const hp: int = 100
const max_hp: int = 100
const jump_height: float = 400.0
const double_jump: bool = false
const slow_fall: bool = false
#endregion

var hold_time : float = 0.0
var hold: bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_timer -= delta
	else:
		coyote_timer = coyote_time

	# Handle jump.
	if Input.is_action_just_pressed("up"):
		if is_on_floor() or coyote_timer > 0.0:
			animated_sprite_2d.play("jump")
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0.0

	if Input.is_action_just_pressed("up") and not is_on_floor():
		hold = true
		hold_time = 0.0
		
	if hold and Input.is_action_pressed("up"):
		if is_on_floor():
			hold = false
			hold_time = 0.0
		else:
			hold_time += delta
			hold_time = clamp(hold_time, 0.0, 1.0)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	update_animation(direction)
	
func update_animation(direction: float) -> void:
	#if is_on_floor():
		#if direction == 0 or direction > 0 or direction:
			#animated_sprite_2d.play("idle")
		#else:
			#animated_sprite_2d.play("jump")
		#
	#if not is_on_floor():
		#animated_sprite_2d.play("fall")
		#print("falling")
	if is_on_floor():
		animated_sprite_2d.play("idle")
	else:
		if animated_sprite_2d.animation == &"jump" and animated_sprite_2d.is_playing():
			return
		animated_sprite_2d.play("fall")
