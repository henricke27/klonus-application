extends HTTPRequest

var userAndKeyConvertedToBase64: String;

func _request(user, key):
	print(key)
	userAndKeyConvertedToBase64 = Marshalls.utf8_to_base64(str(user+":"+key))
	var headerAuth = "Authorization: Basic " + userAndKeyConvertedToBase64
	print(userAndKeyConvertedToBase64)
	var headerContentType = "Content-Type: application/json"
	var headers = [headerAuth, headerContentType]
	var url = "https://klonus-leaderboards.herokuapp.com/auth"
	
	self.request(url, headers, false, HTTPClient.METHOD_GET)
	
func _on_Login_pressed():
	_request(UserData.username, UserData.password)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse(body.get_string_from_utf8())
		PlayerData.addAuthorization(userAndKeyConvertedToBase64)
		PlayerData.addNickname(json.result.nickname)
		PlayerData.addScoreFromDatabase(json.result.score)
		
		get_tree().change_scene("res://Scenes/Fase 1/Start_Menu.tscn")
	else:
		push_error("erro")
	
