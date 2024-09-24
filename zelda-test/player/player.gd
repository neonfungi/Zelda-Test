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
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction = direction.normalized() # Normalize direction for diagonal movement
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
			animated_sprite.flip_h = false
			if direction.y > 0:
				animated_sprite.play("walk_down")
			else:
				animated_sprite.play("walk_up")
