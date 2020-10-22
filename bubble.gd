
extends Area2D

const SPEED = 350
var velocity = Vector2()
var direction = 1
var is_trap = false
const FLOOR = Vector2(0,-1)
var score = 100

func _ready():
	pass

func set_bubble_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true

func _physics_process(delta):
	if is_trap == false:
		velocity.x = SPEED * delta * direction
		velocity.y = 0
		translate(velocity)
	if is_trap == true:
		velocity.x = 0 
		
		translate(velocity)
	if $RayCast2D.is_colliding():
		velocity.y = 0
#	$AnimationPlayer.sprite.play("shoot")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bubble_body_entered(body):
	if  "Enemy" in body.name:
		body.dead()
		is_trap = true
		$Sprite.scale = Vector2(1, 1)
		$Sprite.texture = body.trapped_sprite
	if  "player" in body.name:
		PlayerData.score += score
		queue_free()
	
	velocity.y = -1
	 




