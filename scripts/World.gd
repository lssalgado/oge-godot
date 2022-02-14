extends Node

export(PackedScene) var player_scene
export(PackedScene) var mob_scene

const COLLUMS = 20
const ROWS = 11

const TILE_SIZE = 16

const START_POSITION = Vector2(8.0, 24.0)

var player
var mobs = Array()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func get_tile_position(collum, row):
	var x = (collum * 16 + 8)
	var y = (row * 16 + 8)
	return Vector2(x, y)

func add_mob(collum, row):
	var mob = mob_scene.instance()
	add_child(mob)
	mob.position = get_tile_position(collum, row)
	return mob

func add_mobs():
	for mob in mobs:
		remove_child(mob)
	
	var mob = add_mob(18, 6)
	mobs.append(mob)
	mob = add_mob(12, 3)
	mobs.append(mob)
	mob = add_mob(2, 6)
	mobs.append(mob)

func new_game():
	remove_child(player)
	player = player_scene.instance()
	add_child(player)
	player.position = START_POSITION
	
	add_mobs()

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("restart"):
		new_game()
