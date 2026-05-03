extends Control

var tutorial:String
var max_pages:int
var page=1
@onready var info: Label = $info
@onready var next: Button = $next
@onready var back: Button = $back


func show_up(type:String):
	visible=true
	tutorial=type
	page=1
	page_change()


func page_change():
	if tutorial=="battle":
		if page==1:
			info.label_settings.font_size=64
			info.text="This is the battle screen."
		elif page==2:
			info.label_settings.font_size=32
			info.text="Use your mouse to either fight, use an item, or draw a new sword."
	if tutorial=="fight":
		if page==1:
			info.label_settings.font_size=64
			info.text="This is the fight screen."
		elif page==2:
			info.label_settings.font_size=32
			info.text="Use your mouse to use your basic attack, your sword's blade's skill,
			or your sword's handle's skill."
		elif page==3:
			info.text="Skills will usually consume MP while basic attacks will restore 5 MP.
			A brief description of the skill can be seen in the box to the right of the buttons"

func _on_next_pressed() -> void:
	if page==max_pages:
		visible=false
	else:
		page+=1
		page_change()
		if page==max_pages:
			next.text="Close"


func _on_back_pressed() -> void:
	page-=1
	page_change()
	if page==1:
		back.visible=false
