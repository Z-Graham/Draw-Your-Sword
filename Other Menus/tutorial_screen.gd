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
	if tutorial=="inventory":
		if page==1:
			info.label_settings.font_size=64
			print(info.label_settings.font_size)
			info.text="This is your inventory."
		elif page==2:
			info.label_settings.font_size=32
			info.text="Clicking an item will give you a brief description of its effect
			in the box in the bottom right."
		elif page==3:
			info.text="Click the 'Use' button next to the description panel after selecting an item
			to use that item."
		elif page==4:
			info.text="Click the buttons on the top of the inventory to switch tabs."
	if tutorial=="overworld draw":
		if page==1:
			info.label_settings.font_size=64
			info.text="You just stepped on a draw spot."
		elif page==2:
			info.label_settings.font_size=32
			info.text="These are scattered around the school at points where 
			you will need to draw an item in order to proceed."
		elif page==3:
			info.text="You can find instructions on how to draw certain items
			in chests and from killing enemies."
		elif page==4:
			info.text="Every draw spot has a solution, so if you don't have 
			the correct solution yet,try exploring places you haven't been 
			in order to find the key to the puzzle."

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
