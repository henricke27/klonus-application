extends LineEdit

func _ready():
	pass 

func _on_Register_pressed():
	UserData.addConfirm(self.text)
