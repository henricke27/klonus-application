extends Node2D

var hp = 3
var VelX = 250
var knock_back = 0

signal destroied(node)

func _ready():
	randomize()
	
	var node = get_node("Naves/Inimigo")
	
	node.visible = true



func _process(delta):	
	set_global_scale(Vector2(4,4))
	translate(Vector2(VelX - knock_back, 0) * -1 * delta)
	
	if global_position.x < -40:
		global_position.x = 1350
		global_position.y = rand_range(-50, 770)
	
	if knock_back:
		knock_back = lerp(knock_back, 0, 0.2)


func _on_Area_area_entered(area):
	$AudioStreamPlayer2D.play()
	knock_back = 150
	hp -= 1
	if hp <= 0 or area.collision_layer == 1:
		get_tree().call_group("camera", "treme", 1)
		emit_signal("destroied", self)
		queue_free()
	else:
		get_tree().call_group("camera", "treme", 0.5)
