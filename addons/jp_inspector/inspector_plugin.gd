tool
extends EditorInspectorPlugin

const CATEGORY_SCENE = preload("res://addons/jp_inspector/category/Category.tscn")
const GROUP_SCENE = preload("res://addons/jp_inspector/group/Group.tscn")

const Category = preload("res://addons/jp_inspector/category/Category.gd")
const Group = preload("res://addons/jp_inspector/group/Group.gd")
const FuncButton = preload("res://addons/jp_inspector/button/FuncButton.gd")

var groups: Dictionary
var group_variables: Dictionary
var update_variables_funcref: FuncRef = funcref(self, "update_group_variables")


func can_handle(object: Object) -> bool:
	return true


func parse_property(
		object: Object,
		type: int,
		path: String,
		hint: int,
		hint_text: String,
		usage: int
) -> bool:
	if type == TYPE_DICTIONARY:
		if path.begins_with(jpInspector.CATEGORY_PREFIX):
			var category: Category = CATEGORY_SCENE.instance()
			category.populate(object, path)
			add_custom_control(category)
			return true
		
		if path.begins_with(jpInspector.BUTTON_PREFIX):
			var button := FuncButton.new()
			button.populate(object, path)
			add_custom_control(button)
			return true
		
		if path.begins_with(jpInspector.GROUP_PREFIX):
			var group: Group = GROUP_SCENE.instance()
			var is_group_visible: bool = true
			if _is_group_registered(object, path):
				is_group_visible = _is_group_visible(object, path)
			group.populate(object, path, update_variables_funcref, is_group_visible)
			add_custom_control(group)
			return true
	
	if _is_group_variable(object, path) and not _is_group_variable_visible(object, path):
		return true
	
	return false


func update_group_variables(object: Object, path: String, variables: Array, group: Group) -> void:
	var group_key := _get_group_variable_key(object, path)
	groups[group_key] = group.is_group_visible()
	for variable in variables:
		var key := _get_group_variable_key(object, variable)
		group_variables[key] = group.is_group_visible()

func _is_group_variable(object: Object, variable: String) -> bool:
	var key := _get_group_variable_key(object, variable)
	return group_variables.has(key)

func _is_group_variable_visible(object: Object, variable: String) -> bool:
	var key := _get_group_variable_key(object, variable)
	return group_variables[key]


func _is_group_registered(object: Object, path: String) -> bool:
	var key := _get_group_variable_key(object, path)
	return groups.has(key)

func _is_group_visible(object: Object, path: String) -> bool:
	var key := _get_group_variable_key(object, path)
	return groups[key]


func _get_group_variable_key(object: Object, variable: String) -> String:
	return "%s:%s" % [object.get_instance_id(), variable]
