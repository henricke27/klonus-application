extends Node2D

var PRE_EXPLOSION = preload("res://Scenes/Fase 1/Mini-Explosion.tscn")

var vel = 400

func _ready():
	pass
	
func _process(delta):
	set_global_scale(Vector2(3,2))
	translate(Vector2(1, 0) * vel * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area_area_entered(area):
	var e = PRE_EXPLOSION.instance()
	get_parent().add_child(e)
	e.global_position = global_position
	queue_free()
