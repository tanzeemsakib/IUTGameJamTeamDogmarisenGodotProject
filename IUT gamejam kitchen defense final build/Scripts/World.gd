extends Node2D

var tower = preload("res://Scenes/Tower.tscn")
var mob = preload("res://Scenes/Enemy.tscn")
var instance

var building = false

var money = 25
var ingredients = 0
var wave = 0
var mobs_left = 0
var wave_mobs = [2,5,2,5,3,5,3,0]
var wave_speed = [1,1,0.5,0.5,0.3,0.3,0.2,100]


var seconds = 0
var minutes = 0
var Dseconds = 60
var Dminutes = 0

func _ready():
	$WaveTimer.start()
	Reset_Timer()
	

func _process(delta):
	$GUI/CashLabel.text = "Mana: " + str(money)
	$GUI/CashLabel2.text = "Supplies: " + str(ingredients)
	if ingredients == 20:
		get_tree().change_scene("res://Scenes/Win.tscn")
	if minutes == 0 && seconds == 0:
		get_tree().change_scene("res://Scenes/Lose.tscn")
	
func add_money(amount):
	money += amount
	
	
func tower_built():
	building = false
	money -= 25



func _on_WaveTimer_timeout():
	mobs_left = wave_mobs[wave]
	$MobTimer.wait_time = wave_speed[wave]
	$MobTimer.start()
	



func _on_MobTimer_timeout():
	instance = mob.instance()
	$Path2D.add_child(instance)
	mobs_left -= 1
	if mobs_left <= 0:
		$MobTimer.stop()
		wave +=1
		if wave < len(wave_mobs):
			$WaveTimer.start()
#		else:
#			get_tree().change_scene("res://Scenes/Win.tscn")



func _on_TextureButton_pressed():
	if building == false and money >= 25:
		instance = tower.instance()
		add_child(instance)
		building = true


func _on_Timer_timeout():
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1
	$GUI/Timer/TimeLabel.text = str(minutes)+":"+str(seconds)
	
func Reset_Timer():
	seconds = Dseconds
	minutes = Dminutes
