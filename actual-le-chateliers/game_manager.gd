extends Control


@onready var question_label: RichTextLabel = $question_label
@onready var button: Button = $Button
@onready var enthalpy_label: RichTextLabel = $enthalpy_label
@onready var slider: HSlider = $"slider stuff/slider"
@onready var submit_button: Button = $submit_button
@onready var answer_label: RichTextLabel = $answer_label


var random_of_3=0 # first qs always temp BUT keeps track of which qs type (temp,vol,conc)
var curr_qs="" # current question
#---temp variables-----
var random_select_temp= randi_range(0,5) # random var to choose in temp dict
var curr_enthalpy="" #current enthalpy 

#--------------------
func _ready():
	random_select_temp= 0
	final_temp()
	
func choose_temp_qs():  # HELPER chooses a temp qs from the temp dict
	# already starts from the a random value and then 
	#goes into the actual rxn : enthalpy -> dict always loops through keys 
	var inner_dict=QsData.temp_qs_dict[random_select_temp]
	for rxn in inner_dict :
		curr_qs= rxn
		curr_enthalpy=inner_dict[rxn]

func final_temp(): # Displays temp labels
	random_select_temp= randi_range(0,5)
	choose_temp_qs() # uses helper
	question_label.text= curr_qs
	enthalpy_label.text=curr_enthalpy

func check_temp_ans(value: float) -> void: # HELPER checks temp answers
	if curr_enthalpy=="exothermic" and value<0 :
		answer_label.text="correct !"
	elif curr_enthalpy=="exothermic" and value>0 :
		answer_label.text="wrong :( "
	elif curr_enthalpy=="endothermic" and value>0:
		answer_label.text="correct !"
	else :
		answer_label.text="wrong :( "


func _on_submit_button_pressed() -> void: # displays answer label
	var slider_value= slider.value
	if (random_of_3== 1):
		check_temp_ans(slider_value)
	elif (random_of_3==2):
		pass #vol
	else:
		pass #conc



	

func _on_button_pressed() -> void: # loads in new qs type out of 3 total
	
	enthalpy_label.text=""
	random_of_3= randi_range(1,3)
	if (random_of_3== 1):
		final_temp()
	elif (random_of_3==2):
		question_label.text="volume qs"
	else:
		question_label.text="conc qs"
