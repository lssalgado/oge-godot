extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var heart_scene
onready var grid_container = $GridContainer
var label: Label
var hearts = Array()
var first_time: bool = true
var player_node: Player

func _ready():
	label = $Label
	label.text = "0"

func update_heart_count(amount: int):
	if hearts.size() < amount:
		var hearts_to_add = amount - hearts.size()
		for i in range(0, hearts_to_add, 1):
			var heart = heart_scene.instance()
			hearts.append(heart)
			grid_container.add_child(heart)
	else:
		var hearts_to_remove = hearts.size() - amount
		for i in range(0, hearts_to_remove, 1):
			var heart = hearts.pop_back()
			heart.queue_free()

func _on_player_health_changed(amount: int):
	update_heart_count(amount)


func _on_World_mob_spawned():
	request_ready()
	label.text = str(label.text.to_int() + 1)


func _on_World_player_ready():
	if first_time:
		first_time = false
		player_node = get_tree().get_root().find_node("Player",true,false)
		player_node.connect("health_changed",self,"_on_player_health_changed")
	update_heart_count(player_node.lives)


func _on_World_mob_died():
	label.text = str(label.text.to_int() - 1)
