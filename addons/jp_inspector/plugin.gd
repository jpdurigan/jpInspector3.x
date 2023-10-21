tool
extends EditorPlugin

const jpInspectorPlugin = preload("res://addons/jp_inspector/inspector_plugin.gd")

var jp_inspector: jpInspectorPlugin

func _enter_tree():
	if not is_instance_valid(jp_inspector):
		jp_inspector = jpInspectorPlugin.new()
	add_inspector_plugin(jp_inspector)


func _exit_tree():
	if is_instance_valid(jp_inspector):
		remove_inspector_plugin(jp_inspector)
