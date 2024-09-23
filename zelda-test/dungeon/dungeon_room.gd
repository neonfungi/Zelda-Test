extends Node2D

func _on_player_detector_body_entered(body: Node2D) -> void:
	Events.room_entered.emit(self)

@export var room_size: Vector2 = Vector2(256, 176)  # Size of each room in pixels
var room_position: Vector2

func _ready():
	# Automatically calculate the room's grid position based on its global position, rounded to integers
	room_position = Vector2(floor(global_position.x / room_size.x), floor(global_position.y / room_size.y))
	
	# Print the room's world position and calculated room position for debugging
	print("Room global position: ", global_position, " -> Calculated room_position: ", room_position)

# Getter method to access room position from outside
func get_room_position() -> Vector2:
	return room_position
