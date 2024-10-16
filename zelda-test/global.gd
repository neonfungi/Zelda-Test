extends Node

signal pause_state_changed(is_paused: bool)

func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	emit_signal("pause_state_changed", get_tree().paused)

func unpause() -> void:
	get_tree().paused = false
	emit_signal("pause_state_changed", false)
