extends LineEdit

func _on_Login_pressed():
	UserData.addKey(self.text)
