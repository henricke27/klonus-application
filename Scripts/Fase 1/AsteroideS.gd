extends Node2D

const PRE_ASTEROIDE = preload("res://Scenes/Fase 1/Asteroide.tscn")
const PRE_EXPLOSION = preload("res://Scenes/Fase 1/Explosion.tscn")
const PRE_CRISTAL = preload("res://Scenes/Fase 1/Cristal.tscn")

func _ready():
	restartTimer()

func _process(delta):
	pass


func _on_Spawn_Timer_timeout():
	var ast = create_asteroid()
	add_child(ast)
	ast.global_position = Vector2(1350, rand_range(-50, 770))
	restartTimer()


func restartTimer():
	$Spawn_Timer.wait_time = rand_range(1, 10)
	$Spawn_Timer.start()

func on_asteroid_destroied(ast):
	if ast.chosen == 2:
		for a in range(rand_range(0, 2)):
			var c = PRE_CRISTAL.instance()
			call_deferred("add_child",c)
			c.global_position = ast.global_position
		
		for a in range(randi() % 2 + 2):
			var new_ast = create_asteroid()
			new_ast.chosen = 1
			new_ast.VelY = rand_range(-50, 50)
			call_deferred("add_child",new_ast)
			new_ast.global_position = ast.global_position
	get_tree().call_group("hud", "asteroid_destroied", ast)
	var e = PRE_EXPLOSION.instance()
	add_child(e)
	e.global_position = ast.global_position
	


func create_asteroid():
	var ast = PRE_ASTEROIDE.instance()
	ast.connect("destroied", self, "on_asteroid_destroied")
	return ast
