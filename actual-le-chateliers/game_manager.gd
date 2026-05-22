extends Control

var random_select_temp= randi_range(0,5)
@onready var question_label: RichTextLabel = $question_label
@onready var button: Button = $Button
@onready var enthalpy_label: RichTextLabel = $enthalpy_label
var curr_qs=""
var curr_enthalpy=""
func _ready():
	choose_temp_qs()
	question_label.text= curr_qs
	enthalpy_label.text=curr_enthalpy

func choose_temp_qs():
	# already starts from the a random value and then 
	#goes into the actual rxn : enthalpy -> dict always loops through keys 
	
	var inner_dict=QsData.temp_qs_dict[random_select_temp]
	for rxn in inner_dict :
		curr_qs= rxn
		curr_enthalpy=inner_dict[rxn]
			


func final_temp():
	random_select_temp= randi_range(0,5)
	choose_temp_qs()
	question_label.text= curr_qs
	enthalpy_label.text=curr_enthalpy
	

func _on_button_pressed() -> void:
	enthalpy_label.text=""
	var random_of_3= randi_range(1,3)
	if (random_of_3== 1):
		final_temp()
	elif (random_of_3==2):
		question_label.text="volume qs"
	else:
		question_label.text="conc qs"
