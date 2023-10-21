tool
extends Node
## For this test, change jpInspector settings to:
##	category = "cat_"
##	group = "gro_"
##	button = "but_"

## Categories

# Simple category
export var cat_category_1: Dictionary
export var var_cat1_bool: bool
export var var_cat1_int: int
export var var_cat1_str: String

export var cat_category_2: Dictionary = jpInspector.Category()
export var var_cat2_bool: bool
export var var_cat2_int: int
export var var_cat2_str: String

# Category with custom title
export var cat_category_3: Dictionary = jpInspector.Category("My Category #3")
export var var_cat3_bool: bool
export var var_cat3_int: int
export var var_cat3_str: String

# Category with custom title and icon
export var cat_category_4: Dictionary = jpInspector.Category("My Category #4", "res://icon.png")
export var var_cat4_bool: bool
export var var_cat4_int: int
export var var_cat4_str: String


## Groups

# Simple group
export var gro_group_1: Dictionary
export var gro_group_1_var_grp1_bool: bool
export var gro_group_1_var_grp1_int: int
export var gro_group_1_var_grp1_str: String

export var gro_group_2: Dictionary = jpInspector.Group()
export var gro_group_2_var_grp2_bool: bool
export var gro_group_2_var_grp2_int: int
export var gro_group_2_var_grp2_str: String

# Group from prefix
export var gro_group_3: Dictionary = jpInspector.Group("group3")
export var group3_var_grp3_bool: bool
export var group3_var_grp3_int: int
export var group3_var_grp3_str: String

# Group from a list of properties
export var gro_group_4: Dictionary = jpInspector.GroupCustom(["var_grp4_bool", "var_grp4_int", "var_grp4_str"])
export var var_grp4_bool: bool
export var var_grp4_int: int
export var var_grp4_str: String

# Group with custom title
export var gro_group_5: Dictionary = jpInspector.Group("group5", "My Group #5")
export var group5_var_grp5_bool: bool
export var group5_var_grp5_int: int
export var group5_var_grp5_str: String

# Group from a list of properties with custom title
export var gro_group_6: Dictionary = jpInspector.GroupCustom(["var_grp6_bool", "var_grp6_int", "var_grp6_str"], "My Group #6")
export var var_grp6_bool: bool
export var var_grp6_int: int
export var var_grp6_str: String

## Buttons

# Simple button
export var but_custom_function: Dictionary
export var but_another_custom_function: Dictionary = jpInspector.FuncButton()
export var but_button_1: Dictionary = jpInspector.FuncButton("custom_function")

# Simple button with custom title
export var but_button_2: Dictionary = jpInspector.FuncButton("another_custom_function", "Another Custom Function :3")


func custom_function() -> void:
	printt(self, "Calling custom function!")

func another_custom_function() -> void:
	printt(self, "Calling another custom function!")
