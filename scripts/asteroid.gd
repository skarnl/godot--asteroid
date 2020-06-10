extends RigidBody2D

const BIG_FRAMES = 10
const SMALL_FRAMES = 11

const BIG_RADIUS = 14.5
const SMALL_RADIUS = 8

var rand_generate = RandomNumberGenerator.new()


func _ready():
	yield(get_tree(), "idle_frame")
	
	randomize()
	rand_generate.randomize()
	random_frame()

	var velocity = Vector2.ZERO
	velocity.x += rand_generate.randf_range(-20, 20) + 1
	velocity.y += rand_generate.randf_range(-20, 20) + 1

#	apply_impulse(Vector2(-10, 0), velocity)


func get_random(change:float) -> bool:
	return randf() > (1 - change)
	


func random_frame():
	var go_big = get_random(0.8)
	var target_frame:int
	var collider_radius:float
	
	if go_big:
		target_frame = rand_generate.randi_range(0, BIG_FRAMES)
		collider_radius = BIG_RADIUS
	else:
		target_frame = rand_generate.randi_range(BIG_FRAMES + 1, BIG_FRAMES + SMALL_FRAMES)
		collider_radius = SMALL_RADIUS
	
	print(go_big)	
	print(collider_radius)
	
	$Sprite.frame = target_frame
	$Sprite.flip_h = get_random(0.5)
	$Sprite.flip_v = get_random(0.5)
	$CollisionShape2D.shape.radius = collider_radius
	$CollisionShape2D.position.x += rand_generate.randf_range(10, 100)
	
