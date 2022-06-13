extends Node2D


export(NodePath) var player

func _ready():
	if player:
		player = get_node(player)
	else:
		set_process(false)

func _process(delta):
	global_position.y = (player.global_position.y - 350) * 0.0005 * -720
