extends KinematicBody2D

const ACCELERATION = 900
const MAX_SPEED = 180
const FRICTION = 180

var screen_size : Vector2
var player_rect: Vector2

var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer

var thrusting = false

var route = PoolVector2Array()
var last_input_vector = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	player_rect = $Sprite.texture.get_size()
	player_rect.x = player_rect.x/$Sprite.get_hframes()
	

func _physics_process(delta):
	handleMovement(delta)


func handleMovement(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
		
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		start_thrusting()
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		stop_thrusting()
	
	move_and_slide(velocity)
	look_at(position + velocity)
	store_position(input_vector)

func start_thrusting():
	if not thrusting:
		animation_player.play("StartThrust")
	
	thrusting = true


func stop_thrusting():
	if thrusting:
		animation_player.play("EndThrust")
	
	thrusting = false


func store_position(_input_vector:Vector2):	
#   do we need this optimalisation? it makes the lines less smooth?
#	if (input_vector == last_input_vector):
#		return
		
#	last_input_vector = input_vector
	
	if route.empty():
		route.append(position)
		print("FIRST APPEND")
	else:
		appendPosition()
		
func appendPosition():
	var last_position = route[route.size() - 1]
		
	if position != last_position:
		route.append(position)
		
		print("APPEND")
