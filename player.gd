extends KinematicBody2D


const SPEED = 150
const GRAVITY = 60
const JUMP_POWER = -1500
const FLOOR = Vector2(0,-1)

#signal gameOver

const BUBBLE = preload("res://bubble.tscn")

var velocity = Vector2()

var on_ground = false



var is_dead = false

var is_trap = false

var is_attacking = false 

func _ready():
	set_process(true)
#		$AnimPlayer.play("Setup")



func _physics_process(delta):

	if is_dead == false:
		
		if Input.is_action_pressed("ui_right"):
			if is_attacking == false:
				velocity.x = SPEED
				$AnimatedSprite.play("walk")
				$AnimatedSprite.flip_h = false
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
		
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false:
				velocity.x = -SPEED
				$AnimatedSprite.play("walk")
				$AnimatedSprite.flip_h = true
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
		
		else:
			velocity.x = 0
			if on_ground == true: #&& is_attacking == false :
				$AnimatedSprite.play("idle")
	
		if Input.is_action_pressed("ui_up"):
			if is_attacking == false:
				if on_ground == true:
					$jump.play()
					velocity.y = JUMP_POWER
					on_ground = false
					
	
		if Input.is_action_just_pressed("ui_accept") && is_attacking == false:
			is_attacking = true
			$AnimatedSprite.play("attack")
			$shoot .play()
			var bubble = BUBBLE.instance()
			$AnimatedSprite.play("attack")
			$shoot.play()
			if sign($Position2D.position.x) == 1:
				bubble.set_bubble_direction(1)
			else:
				bubble.set_bubble_direction(-1)
			get_parent().add_child(bubble)
			bubble.position = $Position2D.global_position
			
		velocity.y = velocity.y + GRAVITY

		if is_on_floor():
			on_ground = true
		else:
			on_ground =false
			if velocity.y < 0:
				$AnimatedSprite.play("jump")

	
		velocity = move_and_slide(velocity, FLOOR)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()



func dead():
	is_dead = true
	
	velocity = Vector2(0,0)
#	$AnimatedSprite.play("dead")
	PlayerData.deaths += 1
	queue_free()
	
	$CollisionShape2D.disabled = true









func _on_AnimatedSprite_animation_finished():
	is_attacking = false









func _on_Area2D_body_entered(body):
	dead()
