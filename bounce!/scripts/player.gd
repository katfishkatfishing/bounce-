extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var energy_bar: ProgressBar = $Gui/CanvasLayer/EnergyBar


#region
const max_buildup: float = 300.0
const gpe_buildup_rate: float = 400.0
const fall_velocity_limit: float = 300.0 # limit before damage 
const max_hp: int = 100
const double_jump: bool = false
const slow_fall: bool = false
#endregion

#region
var gpe_buildup : float = 0.0
var is_bouncing_back: bool = false
var coyote_timer: float = 0.0
var coyote_time: float = 0.2
var landing_timer: float = 0.0 #to count how long it takes to land
var peak_fall_speed: float = 0.0
var was_on_floor_last_frame: bool = true
var hp: int = 100
var SPEED = 100.0
var JUMP_VELOCITY = -400.0
#endregion

func _ready() -> void:
	energy_bar.max_value = max_buildup
	energy_bar.value = 0.0
	energy_bar.visible = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_timer -= delta
		if velocity.y > peak_fall_speed:
			peak_fall_speed = velocity.y
		
		if velocity.y > 0.0 and Input.is_action_pressed("up"):
			energy_bar.visible = true
			energy_bar.value = minf(peak_fall_speed * 0.5, max_buildup)
		else:
			energy_bar.visible = false
	else:
		coyote_timer = coyote_time

	var just_landed = is_on_floor() and not was_on_floor_last_frame
	
	if just_landed:
		if Input.is_action_pressed("up") and peak_fall_speed > 0.0:
			gpe_buildup = minf(peak_fall_speed * 0.5, max_buildup)
			is_bouncing_back = true
			landing_timer = coyote_time
			peak_fall_speed = 0.0
			energy_bar.visible = true
			energy_bar.value = gpe_buildup
		else:
			if peak_fall_speed > fall_velocity_limit:
				take_fall_damage(peak_fall_speed)
				print(hp)
			peak_fall_speed = 0.0
			energy_bar.visible = false
	
	# Handle jump.
	if is_bouncing_back:
		landing_timer -= delta
		if Input.is_action_just_released("up"):
			animated_sprite_2d.play("jump")
			velocity.y = JUMP_VELOCITY - gpe_buildup
			reset_bounce_energy()
		elif landing_timer <= 0.0:
			reset_bounce_energy()
	elif (is_on_floor() or coyote_timer > 0.0) and Input.is_action_just_pressed("up"):
		animated_sprite_2d.play("jump")
		velocity.y = JUMP_VELOCITY
		coyote_timer = 0.0
			
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
	
	was_on_floor_last_frame = is_on_floor()
	
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

func take_fall_damage(speed: float) -> void:
	var damage = (speed - fall_velocity_limit) * 0.1
	hp -= int(damage)

#func die

func reset_bounce_energy() -> void:
	gpe_buildup = 0.0
	is_bouncing_back = false
	landing_timer = 0.0
	energy_bar.value = 0.0
	energy_bar.visible = false
