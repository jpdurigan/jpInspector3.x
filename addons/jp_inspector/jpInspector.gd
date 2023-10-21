extends Reference
class_name jpInspector

const CATEGORY_PREFIX_SETTINGS = "jpInspector/category_prefix"
const CATEGORY_PREFIX_DEFAULT = "_c_"
const CATEGORY_KEY_TITLE = "title"
const CATEGORY_KEY_ICON = "icon"

const GROUP_PREFIX_SETTINGS = "jpInspector/group_prefix"
const GROUP_PREFIX_DEFAULT = "_g_"
const GROUP_KEY_TITLE = "title"
const GROUP_KEY_PREFIX = "prefix"
const GROUP_KEY_VARIABLES = "variables"

const BUTTON_PREFIX_SETTINGS = "jpInspector/button_prefix"
const BUTTON_PREFIX_DEFAULT = "_b_"
const BUTTON_KEY_METHOD = "method"
const BUTTON_KEY_TITLE = "title"


static func Category(title: String = "", icon: String = "") -> Dictionary:
	return {
		CATEGORY_KEY_TITLE: title,
		CATEGORY_KEY_ICON: icon,
	}


static func Group(prefix: String = "", title: String = "") -> Dictionary:
	return {
		GROUP_KEY_PREFIX: prefix,
		GROUP_KEY_TITLE: title,
	}


static func GroupCustom(variables: Array = [], title: String = "") -> Dictionary:
	return {
		GROUP_KEY_VARIABLES: variables,
		GROUP_KEY_TITLE: title,
	}


static func FuncButton(method: String = "", title: String = "") -> Dictionary:
	return {
		BUTTON_KEY_METHOD: method,
		BUTTON_KEY_TITLE: title,
	}


static func get_category_title(object: Object, path: String) -> String:
	var title: String = ""
	var category: Dictionary = _eval_from_object(object, path)
	if _dict_has_string(category, CATEGORY_KEY_TITLE):
		title = category[CATEGORY_KEY_TITLE]
	if title.empty():
		title = path.replace(get_category_prefix(), "").capitalize()
	return title


static func get_category_icon(object: Object, path: String) -> String:
	var icon: String = ""
	var category: Dictionary = _eval_from_object(object, path)
	if _dict_has_string(category, CATEGORY_KEY_ICON):
		icon = category[CATEGORY_KEY_ICON]
	return icon


static func get_group_variables(object: Object, path: String) -> Array:
	var variables: Array = []
	var group: Dictionary = _eval_from_object(object, path)
	
	# Custom group
	if _dict_has_array(group, GROUP_KEY_VARIABLES):
		variables = group[GROUP_KEY_VARIABLES]
	
	# Group with custom prefix
	if _dict_has_string(group, GROUP_KEY_PREFIX):
		var prefix = group[GROUP_KEY_PREFIX]
		for property in object.get_property_list():
			var name: String = property.name
			if name != path and name.begins_with(prefix):
				variables.append(name)
	
	# Default group
	if variables.empty():
		for property in object.get_property_list():
			var name: String = property.name
			if name != path and name.begins_with(path):
				variables.append(name)
	
	return variables


static func get_group_title(object: Object, path: String) -> String:
	var title: String = ""
	var group: Dictionary = _eval_from_object(object, path)
	if _dict_has_string(group, GROUP_KEY_TITLE):
		title = group[GROUP_KEY_TITLE]
	if title.empty():
		title = path.replace(get_group_prefix(), "").capitalize()
	return title


static func get_button_method(object: Object, path: String) -> String:
	var method: String = ""
	var button: Dictionary = _eval_from_object(object, path)
	if _dict_has_string(button, BUTTON_KEY_METHOD):
		method = button[BUTTON_KEY_METHOD]
	if method.empty():
		method = path.replace(get_button_prefix(), "")
	return method


static func get_button_title(object: Object, path: String) -> String:
	var title: String = ""
	var button: Dictionary = _eval_from_object(object, path)
	if _dict_has_string(button, BUTTON_KEY_TITLE):
		title = button[BUTTON_KEY_TITLE]
	if title.empty():
		title = path.replace(get_button_prefix(), "").capitalize()
	return title


static func get_category_prefix() -> String:
	return ProjectSettings.get_setting(CATEGORY_PREFIX_SETTINGS)

static func get_group_prefix() -> String:
	return ProjectSettings.get_setting(GROUP_PREFIX_SETTINGS)

static func get_button_prefix() -> String:
	return ProjectSettings.get_setting(BUTTON_PREFIX_SETTINGS)

static func add_all_settings() -> void:
	if not ProjectSettings.has_setting(CATEGORY_PREFIX_SETTINGS):
		ProjectSettings.set_setting(CATEGORY_PREFIX_SETTINGS, CATEGORY_PREFIX_DEFAULT)
	ProjectSettings.set_initial_value(CATEGORY_PREFIX_SETTINGS, CATEGORY_PREFIX_DEFAULT)
	if not ProjectSettings.has_setting(GROUP_PREFIX_SETTINGS):
		ProjectSettings.set_setting(GROUP_PREFIX_SETTINGS, GROUP_PREFIX_DEFAULT)
	ProjectSettings.set_initial_value(GROUP_PREFIX_SETTINGS, GROUP_PREFIX_DEFAULT)
	if not ProjectSettings.has_setting(BUTTON_PREFIX_SETTINGS):
		ProjectSettings.set_setting(BUTTON_PREFIX_SETTINGS, BUTTON_PREFIX_DEFAULT)
	ProjectSettings.set_initial_value(BUTTON_PREFIX_SETTINGS, BUTTON_PREFIX_DEFAULT)

static func remove_all_settings() -> void:
	ProjectSettings.set_setting(CATEGORY_PREFIX_SETTINGS, null)
	ProjectSettings.set_setting(GROUP_PREFIX_SETTINGS, null)
	ProjectSettings.set_setting(BUTTON_PREFIX_SETTINGS, null)


static func _eval_from_object(object: Object, path: String) -> Dictionary:
	var dict: Dictionary = {}
	var script: Script = object.get_script()
	if script != null and not script.is_tool():
		var code: String = script.source_code
		code = code.right(code.find(path))
		code = code.left(code.find("\n"))
		var idx = code.find("jpInspector")
		if idx >= 0:
			code = code.right(code.find("jpInspector"))
			dict = _eval_gdscript(code)
	if dict.empty():
		dict = object.get(path)
	
	return dict


static func _eval_gdscript(code: String) -> Dictionary:
	var gdscript := GDScript.new()
	gdscript.source_code = """
extends Reference

func eval() -> Dictionary:
	return %s
	""" % code
	gdscript.reload()
	var instance: Reference = gdscript.new()
	var value: Dictionary = instance.call("eval")
	return value


static func _dict_has_string(dict: Dictionary, key) -> bool:
	return (
		dict.has(key)
		and typeof(dict[key]) == TYPE_STRING
		and not dict[key].empty()
	)


static func _dict_has_array(dict: Dictionary, key) -> bool:
	return (
		dict.has(key)
		and typeof(dict[key]) == TYPE_ARRAY
		and not dict[key].empty()
	)
