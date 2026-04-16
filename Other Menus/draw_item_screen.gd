extends TextureRect


@onready var object_list: ItemList = $ObjectList

var sel_object


func _on_object_list_item_selected(_index: int) -> void:
	sel_object = object_list.get_item_text(_index)
	print(sel_object)
