tool
extends EditorPlugin

const jpInspectorPlugin = preload("res://addons/jp_inspector/inspector_plugin.gd")

var jp_inspector: jpInspectorPlugin


func _enter_tree() -> void:
	if not is_instance_valid(jp_inspector):
		jp_inspector = jpInspectorPlugin.new()
	add_inspector_plugin(jp_inspector)
	jpInspector.add_all_settings()


func _exit_tree() -> void:
	if is_instance_valid(jp_inspector):
		remove_inspector_plugin(jp_inspector)


func disable_plugin() -> void:
	jpInspector.remove_all_settings()
