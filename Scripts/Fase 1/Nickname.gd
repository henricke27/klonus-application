extends LineEdit


func _ready():
	pass # Replace with function body.

func _on_Register_pressed():
	PlayerData.addNickname(self.text)
