extends TextureRect


@onready var object_list: ItemList = $ObjectList

@export var solution : String

var sel_object

signal solution_gotten


func _on_object_list_item_selected(_index: int) -> void:
	sel_object = object_list.get_item_text(_index)
	if sel_object == solution:
		solution_gotten.emit(solution)
		visible = false
