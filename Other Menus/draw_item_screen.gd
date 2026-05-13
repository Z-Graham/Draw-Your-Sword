extends TextureRect


@onready var object_list: ItemList = $ObjectList
@onready var preview: AnimatedSprite2D = $preview

@export var spot : DrawingSpot 
@export var solution : String

var sel_object

signal solution_gotten
signal closed

@onready var wrong_answer_label: Label = $WrongAnswerLabel

func _on_object_list_item_selected(_index: int) -> void:
	sel_object = object_list.get_item_text(_index)
	if sel_object=="Box":
		preview.play("box set")
	elif sel_object=="Bridge":
		preview.play("bridge set")
	


func _on_confirm_button_pressed() -> void:
	if sel_object == solution:
		solution_gotten.emit(solution, spot)
		visible = false
		preview.play("none")
	else:
		wrong_answer_label.visible = true
		await get_tree().create_timer(1.5).timeout
		wrong_answer_label.visible = false


func _on_button_pressed() -> void:
	visible=false
	closed.emit()
	
