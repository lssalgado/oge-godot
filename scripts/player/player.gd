extends Entity

class_name Player

signal player_dead

onready var sprite = $Sprite
onready var animation_player = $Sprite/AnimationPlayer
onready var animation_effects = $Sprite/AnimationEffects
onready var damage_timer = $Timers/Damage_Timer

func _ready():
	max_speed = 64
	jump_force = 150
	lives = 3

func after_damage_taken():
	animation_effects.play("damage")
	animation_effects.queue("flash")
	damage_timer.start()
	invulnerable = true
	set_collision_mask_bit(2, false)


func on_death():
	emit_signal("player_dead")

func process_horizontal_movement(delta: float):
	.process_horizontal_movement(delta)
	if direction != 0:
		animation_player.play("walk")
		sprite.flip_h = direction < 0
	else:
		animation_player.play("idle")
	
func process_vertical_movement(delta: float):
	resistance = NO_RESISTANCE
	.process_vertical_movement(delta)
	
	if is_on_floor():
		if direction == 0:
			resistance = FRICTION
		if Input.is_action_pressed("ui_up"):
			motion.y = -jump_force
	else:
		if Input.is_action_just_released("ui_up") && motion.y < -jump_force/2:
			motion.y = -jump_force/2
		resistance = AIR_RESISTANCE

func _physics_process(delta: float):
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	physics_process(delta)

func _on_Damage_Timer_timeout():
	animation_effects.play("rest")
	invulnerable = false
	set_collision_mask_bit(2, true)
