extends RigidBody2D

export var speed = 20

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_facing_left

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = Vector2()
	print("Carrot ready")
	if player_facing_left == -1:
		speed = speed * -1
		$Sprite.flip_h = true
	
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
