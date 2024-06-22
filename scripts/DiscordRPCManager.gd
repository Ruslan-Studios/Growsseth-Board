extends Node

# Docs: https://docs.vaporvee.com/discord-rpc-godot#quick-start

# Discord Dev -> Portal Rich Presence -> Art Assets keys
const ART_ASSETS: Dictionary = { "Logo" : "game_logo" }

func _ready():
	# Discord Application ID
	DiscordRPC.app_id = 1254077554529140867
	set_RPC()

func set_RPC(
	details: String = "Nel menu principale",
	state: String = "",
	large_image: String = ART_ASSETS.Logo,
	large_image_text: String = "",
	small_icon: String = ART_ASSETS.Logo,
	small_icon_text: String = "",
	showTimeElapsed: bool = true):
	
	# Schermata attuale dov'è il player
	DiscordRPC.details = details
	# Stato attuale del player
	DiscordRPC.state = state
	# Immagine grande e tooltip
	DiscordRPC.large_image = large_image
	DiscordRPC.large_image_text = large_image_text
	# Incona in basso a destra dell'immagine e tooltip
	DiscordRPC.small_image = small_icon
	DiscordRPC.small_image_text = small_icon_text
	
	if showTimeElapsed == true:
		DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	
	DiscordRPC.refresh() # Always refresh after changing the values!
