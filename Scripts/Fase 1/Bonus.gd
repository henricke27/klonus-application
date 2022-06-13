extends Node2D

func _ready():
	pass 
	
func _process(delta):
	if $TimerBonus.time_left == 0:
		$Label.text = str("")
	else:
		$Label.text = "Bonus " + str(stepify($TimerBonus.time_left, 0.01))
	pass
