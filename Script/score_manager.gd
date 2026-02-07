extends Node

signal score_changed(new_score)
signal key_changed(key_count)
var score : int= 0
var key : int= 0
var green : int= 0
var green_yellow : int= 0
var red : int= 0


func add(points: int):
	score += points
	emit_signal("score_changed", score)

func reset():
	score = 0
	emit_signal("score_changed", score)
	
func add_key(points: int):
	key += points
	emit_signal("key_changed", key)

func reset_key():
	key = 0
	emit_signal("key_changed", key)
