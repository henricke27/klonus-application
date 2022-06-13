extends CanvasLayer

var score = 0
var bonus = 1

func _ready():
	pass

func _process(delta):
	if score > Score.bestscore:
		Score.bestscore = score
	pass
	
	if $Bonus/TimerBonus.time_left > 0:
		bonus = 2
	else:
		bonus = 1


func asteroid_destroied(ast):
	var pontos = (3 - ast.chosen) * 10
	score += pontos * bonus
	PlayerData.scoreCurrent = score
	print('ast ' + str(pontos * bonus))
	$score.text = str(score)

func inimigo_destroied(nav):
	score += 30 * bonus
	PlayerData.scoreCurrent = score
	print(str(30 * bonus))
	$score.text = str(score)

func get_bonus():
	$Bonus/Powerup.play()
	$Bonus/TimerBonus.start()
	pass
