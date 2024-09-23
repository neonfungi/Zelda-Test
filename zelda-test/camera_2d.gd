extends Camera2D

@export var ui_height_percentage: float = -0.13  # Height percentage of the screen taken up by the UI

func _ready() -> void:
	# Connect to the global signal for room change
	Events.room_entered.connect(func(room):
		move_camera_to_room(room))

# Move the camera to the room but apply an offset to avoid the UI
func move_camera_to_room(room):
	# Get the room's global position
	var room_position = room.global_position
	
	# Calculate the screen height and the offset for the UI area
	var screen_height = get_viewport_rect().size.y
	var ui_offset = screen_height * ui_height_percentage
	
	# Set the camera's position but apply the vertical offset to avoid overlapping the UI
	global_position = room_position + Vector2(0, ui_offset)
