extends Control

signal card_info_screen_exited

@export var card_data: CardData

@onready var layout = %Layout
@onready var artwork = %Artwork
@onready var card_name = %Name
@onready var type = %Type
@onready var description = %Description
@onready var lore = %Lore

# Layout
const LAYOUT_RIC = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_EGO = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_PRE = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_TOL = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_NET = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_END = preload("res://textures/cards/layout/layout_default.png")
const LAYOUT_DEFAULT = preload("res://textures/cards/layout/layout_default.png")

# Artwork
@onready var artwork_btn = %ArtworkBtn
@onready var fs_artwork_screen = %FSArtworkScreen
@onready var artwork_fs = %FSArtwork

func _ready():
	if card_data == null:
		return
	card_setup()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and fs_artwork_screen.visible == false:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			card_info_screen_exited.emit()
			queue_free()

func card_setup():
	# Layout - DECK_TYPES { RIC, EGO, PRE, TOL, NET, END }
	match card_data.deck_type:
		Deck.DECK_TYPES.RIC:
			layout.texture = LAYOUT_RIC
		Deck.DECK_TYPES.EGO:
			layout.texture = LAYOUT_DEFAULT
		Deck.DECK_TYPES.PRE:
			layout.texture = LAYOUT_PRE
		Deck.DECK_TYPES.TOL:
			layout.texture = LAYOUT_TOL
		Deck.DECK_TYPES.NET:
			layout.texture = LAYOUT_NET
		Deck.DECK_TYPES.END:
			layout.texture = LAYOUT_END
		_:
			layout.texture = LAYOUT_DEFAULT
	
	# Artwork
	artwork.texture = card_data.artwork
	if artwork.texture != null:
		artwork_fs.texture = artwork.texture
	
	# Card type - CARD_TYPES { T, TS, S }
	match card_data.card_type:
		CardData.CARD_TYPES.T:
			type.text = "[center]T[/center]"
		CardData.CARD_TYPES.TS:
			type.text = "[center]TS[/center]"
		CardData.CARD_TYPES.S:
			type.text = "[center]S[/center]"
	
	# Description
	card_name.text = card_data.card_name
	
	# Description
	description.text = "[fill]" + card_data.description + "[/fill]"
	
	# Lore
	lore.text = "[center]" + card_data.lore + "[/center]"

func _on_artwork_btn_pressed():
	set_process_input(false)
	artwork_btn.visible = false
	fs_artwork_screen.visible = true

func enable_input_process():
	set_process_input(true)
