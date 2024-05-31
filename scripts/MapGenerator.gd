extends Node

#	Title: MAP GENERATOR
#	Description: Map generator based on a seed
#   Made by: NoelEm

# Preload the tile scene
@onready var waterTile: PackedScene = preload("res://scenes/tiles/waterTile.tscn")
@onready var sandTile: PackedScene = preload("res://scenes/tiles/sandTile.tscn")
@onready var caveTile: PackedScene = preload("res://scenes/tiles/caveTile.tscn")
@onready var plainsTile: PackedScene = preload("res://scenes/tiles/plainsTile.tscn")
@onready var forestTile: PackedScene = preload("res://scenes/tiles/forestTile.tscn")

@onready var tiles_: Dictionary = {
	"0": caveTile,
	"1": caveTile,
	"2": forestTile,
	"3": forestTile,
	"4": plainsTile,
	"5": plainsTile,
	"6": sandTile,
	"7": sandTile,
	"8": waterTile,
	"9": waterTile,
}

var mapSize_ = [17, 9]
var map = []

# Seed for map generation
@export var seed_: String = "ZioPera"

# Convert string seed to a number
func seedToNumber(seed: String) -> int:
	var hashed = hash(seed) % 999999999999999999
	return hashed

func instantiate_tile(key: int, coords):
	var toTile = null
	if tiles_.has(str(key)):
		toTile = tiles_[str(key)].instantiate()
	
	if toTile != null:
		toTile.position = Vector3(coords[0], 0, coords[1])
		add_child(toTile)

func instanceMap():
	for x in range(mapSize_[0]):
		for y in range(mapSize_[1]):
			instantiate_tile(map[x][y], Vector2(x, y))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for x in range(mapSize_[0]):
		var row = []
		for y in range(mapSize_[1]):
			row.append(-1)
		map.append(row)
	
	var seed_int = seedToNumber(seed_)
	var melmina_seed = seedToNumber("MelminaVerde")
	
	var noise = FastNoiseLite.new()
	noise.seed = seed_int
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	noise.frequency = 0.075
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise.fractal_lacunarity = 0.99
	noise.fractal_gain = 2
	noise.fractal_weighted_strength = 3
	
	if seed_int == melmina_seed:
		print("Hai appena MelminaVerdato")
		#var me = testingTile.instantiate()
		#add_child(me)
		#me.position = Vector3(i, 0, j)
		#print(me.position)
	else:
		for x in range(mapSize_[0]):
			for y in range(mapSize_[1]):
				var noise_value = noise.get_noise_2d(x, y)
				var int_value = convert_noise_to_int(noise_value)
				map[x][y] = int_value
				#instantiate_tile(int_value, Vector2(x, y))
		
		map[8][4] = 0
		map[7][3] = 9
		map[7][4] = 9
		map[7][5] = 9
		map[8][3] = 9
		map[8][5] = 9
		map[9][3] = 9
		map[9][4] = 9
		map[9][5] = 9
		instanceMap()
		print("Sono sad, ma gioca")
		

func convert_noise_to_int(numb: float) -> int:
	if numb == 0:
		return 0
	while abs(numb) < 1.0:
		numb *= 10
	return int(abs(numb))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
