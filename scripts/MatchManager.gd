extends Node
class_name MatchManager

# Test
const PLAYER = preload("res://scenes/components/Player.tscn")
var p1 = PLAYER.instantiate()
var p2 = PLAYER.instantiate()
var p3 = PLAYER.instantiate()

# Managers
@onready var player_manager = $PlayerManager
@onready var decks_manager = $DecksManager

# Turnistica
enum DAY_PHASES { MORNING, AFTERNOON, NIGHT }

var day_count: int = 0

var current_day_phase: DAY_PHASES = DAY_PHASES.NIGHT

var currentPlayer: Faction.FACTION_TYPES

# Signals
signal next_player_turn(faction: Faction.FACTION_TYPES)

func _ready():
	p1.faction = 0
	p2.faction = 1
	p3.faction = 2
	
	player_manager.add_player(p1)
	player_manager.add_player(p2)
	player_manager.add_player(p3)
	
	for player in player_manager.players:
		next_player_turn.connect(player.on_next_turn)
	
	player_manager.set_faction_order()
	start_next_day()

func _process(delta):
	pass

func d12() -> int:
	return randi_range(1, 12)

func start_next_day():
	day_count += 1
	print("\nNuovo giorno - Giorno %d" % day_count) # GIORNO? GIORNO GIOVANNA? JOJOR EFERTENCE!!!
	current_day_phase = DAY_PHASES.MORNING
	if day_count != 0:
		add_exp_to_players(3)
	start_next_day_phase()

func start_next_day_phase():
	current_day_phase += 1
	if current_day_phase <= 3:
		print("\nNuova fase del giorno - Fase %d" % current_day_phase)
		start_next_turn_loop()
	else:
		start_next_day()

func start_next_turn_loop():
	for player in player_manager.players:
		next_player_turn.emit(player.faction)
		await player_manager.get_player(player.faction, false).turn_ended
	start_next_day_phase()

# EXP
func add_exp_to_players(amount: int):
	for player in player_manager.players:
		player.exp += amount

func add_exp_to_player(targetFaction: Faction.FACTION_TYPES, amount: int):
	for player in player_manager.players:
		if player.faction == targetFaction:
			player.exp += amount
