extends Sprite

export(NodePath) var player

var time = 0.0

func _ready():
	if player:
		player = get_node(player)
	else:
		set_process(false)

func _process(delta):
	time += delta
	material.set_shader_param("desloc", (player.global_position.y - 350) * 0.00005)
	material.set_shader_param("time", time)
