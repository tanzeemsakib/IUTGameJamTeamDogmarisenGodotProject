extends Control


var dialog = [
	'Chef, the royal family banquet is upon us.',
	'But these rats have become quite a menace.',
	'It is hard to cook with them running about the kitchen.',
	'Take care of them, will you.',
	'Place traps atop the empty cabinets and let them do the magic.'
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
