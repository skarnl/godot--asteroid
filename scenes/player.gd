 extends KinematicBody2D

const ACCELERATION = 900
const MAX_SPEED = 180
const FRICTION = 80

var screen_size : Vector2
var player_rect: Vector2

var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer

var thrusting = false

func _ready():
	screen_size = get_viewport_rect().size
	player_rect = $Sprite.texture.get_size()
	player_rect.x = player_rect.x/$Sprite.get_hframes()
	

func _physics_process(delta):
	constrainPlayerToScreen()
		
	handleMovement(delta)


func constrainPlayerToScreen():
	if (position.x <= 0 - player_rect.x / 2):
		position.x = screen_size.x + player_rect.x / 2
	elif (position.x >= screen_size.x + player_rect.x / 2):
		position.x = 0 - player_rect.x / 2
		
	if (position.y <= 0 - player_rect.y / 2):
		position.y = screen_size.y + player_rect.y / 2
	elif (position.y >= screen_size.y + player_rect.y / 2):
		position.y = 0 - player_rect.y / 2


func handleMovement(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
		
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
		if not thrusting:
			animation_player.play("StartThrust")
			thrusting = true
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		if thrusting:
			animation_player.play("EndThrust")
			thrusting = false
		
	move_and_slide(velocity)
	look_at(position + velocity)
