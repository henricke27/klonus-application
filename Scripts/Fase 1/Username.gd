extends LineEdit 

func _on_Login_pressed():
	UserData.addUser(self.text)
	
