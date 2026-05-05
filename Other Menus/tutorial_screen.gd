extends Control

var tutorial:String
var max_pages:int
var page=1
@onready var info: Label = $info
@onready var next: Button = $next
@onready var back: Button = $back


func show_up(type:String, pages:int):
	visible=true
	next.text="Next"
	tutorial=type
	page=1
	max_pages=pages
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
			info.text="Use your mouse to use your basic attack, your sword blade's skill,
			or your sword handle's skill."
		elif page==3:
			info.text="Skills will usually consume MP while basic attacks will restore 5 MP.
			A brief description of the skill can be seen
			in the box to the right of the buttons."
	if tutorial=="draw_1":
		if page==1:
			info.label_settings.font_size=64
			info.text="This is the drawing screen."
		elif page==2:
			info.label_settings.font_size=32
			info.text="This is where you will be able to modify your sword to fit your needs."
		elif page==3:
			info.text="Every sword blade and handle have a different skill attatched to them
			while imbues change the type of damage your weapon will do."
		elif page==4:
			info.text="You can collect sword parts and imbues from either
			special enemies or chests located in the overworld."
		elif page==5:
			info.text="Begin by selecting your blade, then hitting the NEXT button on the right."

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
