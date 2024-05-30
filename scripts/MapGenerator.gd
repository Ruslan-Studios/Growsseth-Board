extends Node

#	Title: MAP GENERATOR
#	Description: Map generator based on a seed
#   Made by: NoelEm

# Preload the tile scene
@onready var testingTile: PackedScene = preload("res://scenes/tiles/structures/testTile.tscn")

# Dictionary to hold tile instances
var tiles_: Dictionary = {}

var mapSize_ = [17, 9]

# Seed for map generation
@export var seed_: String = "MelminaVerde"

# Convert string seed to a number
func seedToNumber(seed: String) -> int:
	var hashed = hash(seed) % 999999999999999999
	return hashed

func NoisetoInt(numb: float) -> int:
	while numb < 1.0:
		numb *= 10
	numb = abs(numb)
	return int(floor(numb))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var seed_int = seedToNumber(seed_)
	var melmina_seed = seedToNumber("MelminaVerd")
	
	var noise = FastNoiseLite.new()
	noise.seed = seed_int
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	
	if seed_int == melmina_seed:
		print("Hai appena MelminaVerdato")
		#var me = testingTile.instantiate()
		#add_child(me)
		#me.position = Vector3(i, 0, j)
		#print(me.position)
	else:
		for x in range(17):
			for y in range(9):
				pass
				# print( NoisetoInt(noise.get_noise_2d(x, y)) )
		
		print("Sono sad, ma gioca")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
