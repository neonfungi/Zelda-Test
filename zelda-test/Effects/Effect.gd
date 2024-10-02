extends AnimatedSprite2D

func _ready():
	connect("animation_finished", Callable(self, "_on_animated_sprite_2d_animation_finished"))
	frame = 0
	play("Animate")

func _on_animated_sprite_2d_animation_finished():
	queue_free()
