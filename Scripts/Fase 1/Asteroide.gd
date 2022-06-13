extends Node2D

var chosen = 0
var hp = 0
onready var VelX = rand_range(100, 300)
var VelY = 0
var knock_back = 0

signal destroied(node)

var hps = [rand_range(1,2),rand_range(3,4)]

func _ready():
	randomize()
	
	for a in $Asteroides.get_children():
		a.visible = false
	
	if not chosen:
		chosen = (randi() % $Asteroides.get_child_count()) + 1
	
	hp = hps[chosen - 1]
	
	var node = get_node("Asteroides/Asteroid-" + str(chosen))
	
	node.visible = true
	
	$Area/CollisionShape.shape.radius = node.texture.get_width() / 2



func _process(delta):
	if not VelY:
		VelY = 0
	
	set_global_scale(Vector2(3,3))
	translate(Vector2(VelX - knock_back, VelY) * -1 * delta)
	
	if global_position.y < -50:
		global_position.y = 770
	if global_position.y > 770:
		global_position.y = -50
	
	if global_position.x < -40:
		global_position.x = 1350
		global_position.y = rand_range(-50, 770)
	
	if knock_back:
		knock_back = lerp(knock_back, 0, 0.2)


func _on_Area_area_entered(area):
	$AudioStreamPlayer2D.play()
	knock_back = 50
	hp -= 1
	if hp <= 0 or area.collision_layer == 1:
		get_tree().call_group("camera", "treme", 1)
		emit_signal("destroied", self)
		queue_free()
	else:
		get_tree().call_group("camera", "treme", 0.5)
		
