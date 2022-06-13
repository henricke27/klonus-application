extends Node2D

const PRE_ASTEROIDE = preload("res://Scenes/Fase 1/Nave.tscn")
const PRE_EXPLOSION = preload("res://Scenes/Fase 1/Explosion.tscn")

func _ready():
	restartTimer()

func _process(delta):
	pass


func _on_Spawn_Timer_timeout():
	var nav = create_nave()
	add_child(nav)
	nav.global_position = Vector2(1350, rand_range(-50, 770))
	restartTimer()


func restartTimer():
	$Spawn_Timer.wait_time = rand_range(2, 12)
	$Spawn_Timer.start()

func on_nave_destroied(nav):
	get_tree().call_group("hud", "inimigo_destroied", nav)
	var e = PRE_EXPLOSION.instance()
	add_child(e)
	e.global_position = nav.global_position


func create_nave():
	var nav = PRE_ASTEROIDE.instance()
	nav.connect("destroied", self, "on_nave_destroied")
	return nav
