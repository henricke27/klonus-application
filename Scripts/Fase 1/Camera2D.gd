extends Camera2D

var time = 0
var forca = 0

func _ready():
	pass


func _process(delta):
	if forca > 0:
		time += delta * 100
		global_position = Vector2(forca, forca).rotated(time)
		forca = lerp(forca, 0, 0.05)


func treme(f):
	forca += f
