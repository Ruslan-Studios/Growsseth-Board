extends User
class_name Player

var user: User
@export var faction: Faction.FACTION_TYPES
var cards: Array[CardData] = []
var inventory: Array = []

const MAX_HP: int = 20
const MAX_EXP: int = 30
var hp: int
var exp: int = 0
var tile_x: int
var tile_y: int

var isMyTurn: bool = false
var isDead: bool = false

@onready var turn_timer = $TurnTimer

# Signals
signal turn_ended(previousFaction: Faction.FACTION_TYPES)

func _ready():
	hp = MAX_HP
	#tile_x = 
	#tile_y = 

func _process(delta):
	pass

# Connessa al signal next_player_turn in MatchManager
func on_next_turn(faction: Faction.FACTION_TYPES):
	if faction == self.faction:
		isMyTurn = true
		print("Turno di " + str(faction))
		turn_timer.start()
		print("Turn timer start")
	else:
		isMyTurn = false

# Separato dal pulsante per il tempo limite
func end_turn():
	turn_ended.emit(faction)

func on_end_turn_btn_pressed():
	print("Player imput: Fine turno")
	end_turn()

func _on_timer_timeout():
	print("Timeout: Fine turno")
	end_turn()
