extends Node2D

const PRE_LASER = preload("res://Scenes/Fase 1/Laser.tscn")
const PRE_EXPLOSION = preload("res://Scenes/Fase 1/Explosion.tscn")

export(NodePath) var laseres

var vel = 150
onready var anim = $AnimationPlayer

var escudo = 100
var tempo = 0

onready var escudo_size = $Escudo/Sprite.material.get_shader_param("size")

onready var shape_size = $Area/Shape.shape.radius

func _ready():
	if laseres:
		laseres = get_node(laseres)
	else:
		laseres = get_parent()


func _process(delta):
	var dirX = 0
	var dirY = 0

	movement(dirX, dirY, delta)
	
	if Input.is_action_pressed("ui_accept"):
		if tempo == 0:
			if get_tree().get_nodes_in_group("laseres").size() < 3:
				var laser = PRE_LASER.instance()
				laseres.add_child(laser)
				laser.global_position = $Blaster.global_position
				
				tempo = 1
				$TimerTiro.start()
	
	pass

func movement(dirX, dirY, delta):
	if Input.is_action_pressed("ui_right"):
		dirX += 1
	if Input.is_action_pressed("ui_left"):
		dirX += -1
	if Input.is_action_pressed("ui_down"):
		dirY += 1
		anim.play("Down")
	elif Input.is_action_pressed("ui_up"):
		dirY += -1
		anim.play("Up")
	elif Input.is_action_pressed("ui_up_left"):
		dirY += -1
		dirX += -1
		anim.play("Up")
	elif Input.is_action_pressed("ui_up_right"):
		dirY += -1
		dirX += 1
		anim.play("Up")
	elif Input.is_action_pressed("ui_down_left"):
		dirY += 1
		dirX += -1
		anim.play("Down")
	elif Input.is_action_pressed("ui_down_right"):
		dirY += 1
		dirX += 1
		anim.play("Down")
	else:
		anim.play("Idle")
		
	translate(Vector2(dirX, dirY) * vel * delta)
	
	global_position.x = clamp(global_position.x, 180, 1100)
	global_position.y = clamp(global_position.y, 33, 699)


func _on_Area_area_entered(area):
	if area.get_parent().has_method("destroi"):
		area.get_parent().destroi()
	
	if area.collision_layer == 4:
		get_tree().call_group("camera", "treme", 3)
		escudo -= 10
		$Area/Shape.shape.radius = shape_size * escudo / 100
		$Escudo/Sprite.material.set_shader_param("size", escudo_size * escudo / 100)


func _on_Dead_area_area_entered(area):
	visible = false
	set_process(false)
	var e = PRE_EXPLOSION.instance()
	add_child(e)
	e.global_position = global_position
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Fase 1/Game_Over.tscn")


func _on_TimerTiro_timeout():
	tempo = 0
