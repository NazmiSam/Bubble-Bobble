extends Area2D

const Enemy = preload("res://Enemy2.tscn")


func _ready():
	pass



func _on_Timer_timeout():
	var enemy = Enemy.instance()

	get_parent().add_child(enemy)
	enemy.position = $Position2D.global_position
