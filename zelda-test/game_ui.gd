extends Control

func _ready() -> void:
	# Connect to the custom pause state signal in the global singleton
	Global.connect("pause_state_changed", Callable(self, "_on_paused_changed"))
	# Set the initial position based on the current paused state
	_on_paused_changed(get_tree().paused)

# This function is called whenever the game's paused state changes
func _on_paused_changed(is_paused: bool) -> void:
	# Determine the target position based on whether the game is paused
	var target_position = Vector2(0, 0) if is_paused else Vector2(position.x, -176)

	# Create a new tween to animate the position change
	var tween = get_tree().create_tween()
	tween.set_pause_mode(2)  # Make sure the tween runs even when paused
	tween.tween_property(self, "position", target_position, 0.5)
