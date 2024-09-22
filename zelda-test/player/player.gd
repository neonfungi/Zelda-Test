extends CharacterBody2D

# Movement variables
@export var speed: float = 100.0

# Direction vector
var direction: Vector2 = Vector2.ZERO

# AnimatedSprite2D reference
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame
func _process(delta: float) -> void:
	get_input()
	update_animation()

# Function to get directional input from the player
func get_input() -> void:
	direction = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	elif Input.is_action_pressed("ui_right"):
		direction.x += 1

	# Normalize the direction to avoid faster diagonal movement
	direction = direction.normalized()

# Move the player using CharacterBody2D's move_and_slide
	velocity = direction * speed
	move_and_slide()

# Function to update the player's animation based on movement direction
func update_animation() -> void:
	if direction == Vector2.ZERO:
		animated_sprite.stop()  # Stop animation when not moving
	else:
		if direction.x != 0:
			# Play walk_sideways animation and flip for left movement
			animated_sprite.play("walk_sideways")
			animated_sprite.flip_h = direction.x < 0  # Flip sprite when moving left
		elif direction.y != 0:
			if direction.y > 0:
				animated_sprite.play("walk_down")
			else:
				animated_sprite.play("walk_up")
