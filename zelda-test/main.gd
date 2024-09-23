extends Node2D

@onready var map_control = $CanvasLayer/MapControl  # Reference to the MapControl
@onready var dungeon = $Dungeon  # Reference to the node holding all rooms

func _ready():
	# Call the minimap generator and pass the rooms node
	map_control.generate_minimap(dungeon)
