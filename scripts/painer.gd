extends Node2D

onready var player = $"../Player"
	
var color = Color.crimson
	
func _ready():
	color.a = 0.4
	
func _draw():
	if player.route.empty():
		return
	
	draw_polyline(player.route, color, 2, true)


func _on_Timer_timeout():
	update()
