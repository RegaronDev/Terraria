extends Node2D


@export var xy = 500
@export var yx = 500


func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		get_tree().reload_current_scene()

func _ready():
	var fnl = FastNoiseLite.new()
	fnl.seed = randi_range(0,500)
	fnl.noise_type = FastNoiseLite.TYPE_SIMPLEX
	fnl.fractal_octaves = 2
	
	for x in range(xy):
		for y in range(yx):
			var noise = floor(abs(fnl.get_noise_2d(x,y)*2))
			if noise == 0:
				$Grass.set_cell(0,Vector2(x,y),0,Vector2(0,0))
			elif noise == 1:
				$Air.set_cell(0,Vector2(x,y),0,Vector2(0,0))
			elif noise == 3:
				$Dirt.set_cell(0,Vector2(x,y),0,Vector2(0,0))
