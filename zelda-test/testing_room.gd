extends Node2D

func _input(event):
	if event.is_action_pressed("ui_pause"):
		if get_tree().paused:
			Global.unpause()  # Unpause if already paused
		else:
			Global.toggle_pause()  # Otherwise, pause the game
