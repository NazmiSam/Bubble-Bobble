extends KinematicBody2D

var velocity = Vector2()
var direction = -1
var hp = 1
var is_dead = false
var trapped_sprite = preload("res://Alien sprites/alienPink_badge2.png")
#var TRAP = preload("res://trappedEnemy.tscn")

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction

func dead():
	hp -= 1
	if hp<= 0:
		is_dead = true
		
		$CollisionShape2D.set_deferred("disabled",true) 
		$Timer.start()

func _physics_process(delta):
	
		
	if is_on_wall() or not $floor_checker.is_colliding():
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction

	velocity.y += 20
	
	velocity.x = 50 * direction

	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Timer_timeout():
	queue_free()
