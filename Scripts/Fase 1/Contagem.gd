extends Node2D

var tempo = 3

func _ready():
	pass 
	
func _process(delta):
	pass


func _on_Timer_timeout():
	tempo -= 1
	$Label.text = str(tempo)
	if tempo == 0:
		$Label.text = str("Vai!")
		get_tree().paused = false
	elif tempo < 0:
		queue_free()
