extends Node

export(PackedScene) var player_scene

const START_POSITION = Vector2(8.0, 24.0)
var player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func new_game():
#	get_tree().call_group("players", "queue_free")
	remove_child(player)
	player = player_scene.instance()
	add_child(player)
	player.position = START_POSITION

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("restart"):
		new_game()
