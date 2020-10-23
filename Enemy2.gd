extends KinematicBody2D

var velocity = Vector2()
var direction = 1
var hp = 1
var is_dead = false
var trapped_sprite = preload("res://Alien sprites/alienGreen_badge2.png")
#var TRAP = preload("res://trappedEnemy.tscn")

func _ready():
	pass

func dead():
	hp -= 1
	if hp<= 0:
		is_dead = true
		
		$CollisionShape2D.set_deferred("disabled",true) 
		$Timer.start()

func _physics_process(delta):

	if is_on_wall():
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		
	velocity.y += 20
	
	velocity.x = 70 * direction

	velocity = move_and_slide(velocity, Vector2.UP)

	if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()

func _on_Timer_timeout():
	queue_free()



