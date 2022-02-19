extends Entity

class_name Player

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

func _ready():
	max_speed = 64
	jump_force = 150

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
	
