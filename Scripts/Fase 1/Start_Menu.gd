extends Node2D


func _ready():
	pass

func _process(delta):	
	if $Iniciar.is_pressed():
		$Timer.start()
	pass


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Fase 1/Game.tscn")
