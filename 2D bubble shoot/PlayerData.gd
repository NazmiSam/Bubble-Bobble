extends Node


signal score_updated
signal died

var deaths: = 0 setget set_deaths

var score = 0 setget set_score

func reset():
	self.score = 0
	self.deaths = 0


func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")

func set_deaths(new_value: int) -> void:
	deaths = new_value
	emit_signal("died")
