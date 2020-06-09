extends Node2D

func _draw():
	draw_rect(Rect2(Vector2.ZERO, get_viewport_rect().size), Color.greenyellow, false, 2, true)
