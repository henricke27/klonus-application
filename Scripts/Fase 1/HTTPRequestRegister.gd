extends HTTPRequest

func _request(username, password, nickname):
	var headerContentType = "Content-Type: application/json"
	var headers = [headerContentType]
	var info = {"username": username, "password": password, "nickname": nickname}
	var body = JSON.print(info)
	var url = "https://klonus-leaderboards.herokuapp.com/register"
	
	self.request(url, headers, false, HTTPClient.METHOD_POST, body)
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print(response_code)
	
	if response_code == 201:
		UserData.username = ""
		UserData.password = ""
		PlayerData.nickname = ""
		get_tree().change_scene("res://Scenes/Fase 1/interface.tscn")
	else:
		if response_code == 401:
			push_error("Nome de usuario ou de jogador ja possui um cadastro")
		else:
			push_error("Erro inesperado")

func _on_Register_pressed():
	
	var cond1 = str(UserData.username).length() >= 5 && str(UserData.username).length() <= 20
	var cond2 = str(PlayerData.nickname).length() >= 5 && str(PlayerData.nickname).length() <= 20
	var cond3 = str(UserData.password).length() >= 5 && str(UserData.password).length() <= 20
	
	if cond1 && cond2 && cond3:
		if UserData.confirm == UserData.password:	 
			_request(UserData.username, UserData.password, PlayerData.nickname)
		else:
			push_error("Senha não confirmada!")
	else:
		push_error("A quantidade de caracteres de qualquer campo deve ser >= 5 ou <= 20")
