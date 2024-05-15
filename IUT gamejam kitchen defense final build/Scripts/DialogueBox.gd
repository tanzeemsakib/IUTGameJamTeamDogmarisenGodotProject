extends Control


var dialog = [
	'Chef, the royal family banquet is upon us.',
	'But these rats have become quite the menace.',
	'It is hard to cook with them running about the kitchen.',
	'What is more infuriating is these rodents running off with our supplies!',
	'Take care of them, will you?',
	'Place the rune traps atop the empty cabinets and let them do the magic.',
	'The rune traps require some mana to build, mana you can collect from the dead vermins.',
	'The spells these traps cast should be enough to net a total of 20 bags of supplies.',
	'Do so in under a minute and we can still turn this disaster of a feast around.'
]

var dialog_index = 0
var finished = false

func _ready():
	load_dialog()
	
func _process(_delta):
	$"next- indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
	
func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		get_tree().change_scene("res://Scenes/World.tscn")
	dialog_index += 1


func _on_Tween_tween_completed(_object, _key):
	finished = true
