extends Node2D

var newScore;
var oldScore;

func _ready():
	newScore = PlayerData.scoreCurrent
	oldScore = PlayerData.scoreFromDatabase
	
	if newScore > oldScore: 
		_request()
		PlayerData.scoreFromDatabase = newScore;
		print("Novo recorde")
	else:
		print("Tente outra vez")
		
	PlayerData.scoreCurrent = 0;
	pass

func _process(delta):	
	if $Options/Reiniciar.is_pressed():
		$Timer.start()
	pass
	
	if $Options/Sair.is_pressed():
		get_tree().change_scene("res://Scenes/Fase 1/Start_Menu.tscn")


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Fase 1/Game.tscn")
	
func _request():
	var request = HTTPRequest.new()
	add_child(request)
	
	request.connect("request_completed", self, "_http_request_completed")
	
	var headerAuth = "Authorization: Basic " + PlayerData.authorization;
	var headerContentType = "Content-Type: application/json"
	var headers = [headerAuth, headerContentType]
	var score = newScore
	var body = JSON.print(score)
	print(body)
	var url = "https://klonus-leaderboards.herokuapp.com/score"
	
	var error = request.request(url, headers, false, HTTPClient.METHOD_PATCH, body)
	
	if error != OK:
		push_error("Error");
		
func _http_request_completed(result, response_code, headers, body):
	if response_code == 206:
		PlayerData.scoreFromDatabase = newScore

