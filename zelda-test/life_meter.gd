extends GridContainer

@export var max_health: int = 6  # Maximum health (each unit is half a heart)
@export var current_health: int = 6  # Current health (each unit is half a heart)

# Load the heart textures
@onready var full_heart_texture = preload("res://UI/heart_full.png")
@onready var half_heart_texture = preload("res://UI/heart_half.png")
@onready var empty_heart_texture = preload("res://UI/heart_empty.png")

func _ready() -> void:
	update_hearts()

# Update the heart display
func update_hearts() -> void:
	# Clear any existing children
	for child in get_children():
		remove_child(child)
		child.queue_free()

	# Add heart icons based on current health and max health
	for i in range(max_health / 2):
		var heart = TextureRect.new()
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT

		if current_health >= (i + 1) * 2:
			heart.texture = full_heart_texture
		elif current_health == (i * 2) + 1:
			heart.texture = half_heart_texture
		else:
			heart.texture = empty_heart_texture
		
		add_child(heart)

# Set the health values (this can be called from other scripts)
func set_health(new_current: int, new_max: int) -> void:
	max_health = new_max
	current_health = new_current
	update_hearts()
