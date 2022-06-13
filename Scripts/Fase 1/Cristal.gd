extends Node2D

var dir = Vector2()
var rot = 0

func _ready():
	randomize()
	var frames = $Cristais.hframes * $Cristais.vframes
	$Cristais.frame = randi() % frames
	
	dir = Vector2(rand_range(-150, -80),rand_range(-45, 45))
	rot = rand_range(-15, 15)


func _process(delta):
	translate(dir * delta)
	rotate(rot * delta)


func _on_area_area_entered(area):
	get_tree().call_group("hud", "get_bonus")
	queue_free()
