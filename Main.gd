extends Node

export (PackedScene) var Mob
export (PackedScene) var Carrot

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score

var screen_size

var player_facing_left

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_hit():
	game_over()
	$MobTimer.stop()
	print("Game over")

func game_over():
	#$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("carrots", "queue_free")
	
func new_game():
	score = 0
	print($Player.position)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	

func _on_MobTimer_timeout():
	# DEFINE MOB SPAWN LOCATION
	#screen_size = get_viewport_rect().size
	#
	
	var mob = Mob.instance()
	add_child(mob)
	
	mob.position.x = 730
	mob.position.y = randi() % 450
	mob.linear_velocity = Vector2(-rand_range(mob.min_speed, mob.max_speed), rand_range(-mob.max_speed, mob.max_speed))


func _on_Player_fire_carrot():
	var carrot = Carrot.instance()
	add_child(carrot)
	print(player_facing_left)
	carrot.player_facing_left = player_facing_left
	carrot.position = Vector2($Player.position)
	carrot.linear_velocity = Vector2(carrot.speed , 0)


func _on_Player_facing_left():
	player_facing_left = -1

func _on_Player_facing_right():
	player_facing_left = 0
