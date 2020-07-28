extends KinematicBody2D

signal hit
signal fire_carrot
signal facing_left
signal facing_right

export (PackedScene) var Carrot
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#PLAYER SPEED
export var speed = 100

# SCREEN SIZE
var screen_size

# PLAYER FACING LEFT SIDE
#var left_side
# REPLACED BY SIGNAL FACING_LEFT


# LITERALLY DEFINIG WHAT'S UP

const UP = Vector2(0, -1)
const GRAVITY = 20
const JUMP_HEIGHT = -500

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += GRAVITY
	print(position)
	# CHECKING FOR INPUTS
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	else:
		velocity.x = 0
	
	# CARROT SHOOTING
	if Input.is_action_just_pressed("ui_select"):
		emit_signal("fire_carrot")
#		var carrot = Carrot.instance()
#		add_child(carrot)
#		print("Carrot created")
#		carrot.position.x = position.x + (50 * left_side)
#		carrot.position.y = position.y
#		carrot.linear_velocity = Vector2(300 * left_side, 0)
#		carrot.apply_central_impulse(Vector2(55 * left_side, 0))
#
		
		
	if is_on_floor():
		
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_HEIGHT
			
	
	
	
	# MOVING AND PLAYING ANIMATIONS BASED ON PLAYER MOVEMENT
#
#	if velocity.x != 0:
##		velocity = velocity.normalized() * speed
#		$AnimatedSprite.play()
#	else:
#		$AnimatedSprite.stop()
#
	#RESTRICTING AND ADJUSTING PLAYER MOVEMENT
	
	#position += velocity * delta
	
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# FLIPPING ANIMATION BASE ON PLAYER SIDE
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "moving"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x > 0
		print("If statement entered")
		$AnimatedSprite.play()
#	elif velocity.y != 0:
#		$AnimatedSprite.play(JUMP)
	else:
		$AnimatedSprite.stop()
		
	if velocity.x > 0:
		emit_signal("facing_left")
#	else:
#		left_side = -1
	
	velocity = move_and_slide(velocity, UP)
	
# COLLISION DETECTION

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

# PLAYER INITIATION FUNCTION

func start(pos):
	position = pos
	print(position)
	show()
	$CollisionShape2D.disabled = false
	
