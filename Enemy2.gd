extends KinematicBody2D

var velocity = Vector2()
var direction = 1
var hp = 1
var is_dead = false
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
	
	velocity.x = 50 * direction

	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Timer_timeout():
	queue_free()



