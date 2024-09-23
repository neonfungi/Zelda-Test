extends Control

@export var room_size_on_map: Vector2 = Vector2(8, 8)  # Size of each map room block
@export var room_texture: Texture  # Texture for each map room icon
@export var in_room_texture: Texture  # Texture for the player's current room on the map

var room_positions = []  # Holds the positions of rooms
var current_room: Vector2 = Vector2(-1, -1)  # Stores the current room position (initialized to an invalid value)

func _ready():
	Events.connect("room_entered", Callable(self, "_on_room_entered"))

# Updates to current room upon entering
func _on_room_entered(room: Node):
	current_room = room.get_room_position()  # Store the current room position
	draw_minimap()  # Redraw the minimap with the updated room

func generate_minimap(Dungeon: Node):
	# Clear the current room positions
	room_positions.clear()
	
	# Collect room positions
	for room in Dungeon.get_children():
		if room.has_method("get_room_position"):
			room_positions.append(room.get_room_position())
	
	# Print collected room positions
	print("Collected room positions:", room_positions)
	
	# Draw the minimap only if there are rooms
	if room_positions.size() > 0:
		draw_minimap()

func draw_minimap():
	if room_positions.size() == 0:
		return
	
	# Clear any previous children from the minimap
	for child in get_children():
		child.queue_free()

	# Determine the bounds of the map (min/max x and y)
	var min_x = room_positions[0].x
	var min_y = room_positions[0].y
	var max_x = room_positions[0].x
	var max_y = room_positions[0].y
	
	# Loop through room positions to find the min and max x/y values
	for pos in room_positions:
		min_x = min(min_x, pos.x)
		max_x = max(max_x, pos.x)
		min_y = min(min_y, pos.y)
		max_y = max(max_y, pos.y)

	# Manually place each room in the minimap based on their room positions
	for pos in room_positions:
		var room_icon = TextureRect.new()

		# Check if this room is the current room the player is in
		if pos == current_room:
			room_icon.texture = in_room_texture  # Use the "In Room" texture for the current room
		else:
			room_icon.texture = room_texture  # Use the default texture for other rooms

		room_icon.set_custom_minimum_size(room_size_on_map)  # Set the size of each room block

		# Calculate the position on the minimap
		var x_position = (pos.x - min_x) * (room_size_on_map.x + 1)  # Add 1 pixel of spacing
		var y_position = (pos.y - max_y) * (room_size_on_map.y + 1)

		print("Placing room at:", Vector2(x_position, y_position), " for room_position:", pos)

		# Set the room icon position
		room_icon.position = Vector2(x_position, y_position)
		add_child(room_icon)
