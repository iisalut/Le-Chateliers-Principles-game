extends Control


@onready var question_label: RichTextLabel = $question_label
@onready var button: Button = $Button
@onready var enthalpy_label: RichTextLabel = $enthalpy_label
@onready var slider: HSlider = $"slider stuff/slider"
@onready var submit_button: Button = $submit_button
@onready var answer_label: RichTextLabel = $answer_label
@onready var score_label: RichTextLabel = $"static stuff/score_label"
@onready var question_description: RichTextLabel = $question_description

var score=0 # rn bug if player click submit button will inc :( fix later
var random_of_3=1 # first qs always temp BUT keeps track of which qs type (temp,vol,conc)
var curr_qs="" # current question

#---temp variables and functions-----
var random_select_temp= randi_range(0,5) # random var to choose in temp dict
var curr_enthalpy="" #current enthalpy 
var heat_added= randf()<0.5 # boolean value that manages the heat added/ removed aspect

func choose_temp_qs():  # HELPER chooses a temp qs from the temp dict
	# already starts from the a random value and then 
	#goes into the actual rxn : enthalpy -> dict always loops through keys 
	var inner_dict=QsData.temp_qs_dict[random_select_temp]
	for rxn in inner_dict :
		curr_qs= rxn
		curr_enthalpy=inner_dict[rxn]

func check_temp_ans(value: float) -> void: # HELPER checks temp answers
	if(heat_added):
		if curr_enthalpy=="exothermic" and value<0 :
			answer_label.text="correct !"
			score+=1
		elif curr_enthalpy=="exothermic" and value>0 :
			answer_label.text="wrong (heat is added) "
		elif curr_enthalpy=="endothermic" and value>0:
			answer_label.text="correct !"
			score+=1
		else :
			answer_label.text="wrong (heat is added) "
	else:
		if curr_enthalpy=="exothermic" and value<0 :
			answer_label.text="wrong (heat is removed) "
		elif curr_enthalpy=="exothermic" and value>0 :
			answer_label.text="correct !"
			score+=1
		elif curr_enthalpy=="endothermic" and value>0:
			answer_label.text="wrong (heat is removed) "
		else :
			answer_label.text="correct !"
			score+=1
	score_label.text= "Score:"+str(score)
func display_temp(): # Displays temp labels
	random_select_temp= randi_range(0,5)
	
	choose_temp_qs() # uses helper
	question_label.text= curr_qs
	enthalpy_label.text="ΔH : "+curr_enthalpy
	heat_added= randf()<0.5
	if(heat_added==true):
		question_description.text="If the temperature of the system is increased, how will the equilibrium shift?"
	else:
		question_description.text="If the system is cooled down, how will the equilibrium shift?"
	

#--------------------
func _ready():
	display_temp()

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
	question_description.text=""
	random_of_3= randi_range(1,3)
	if (random_of_3== 1):
		display_temp()
	elif (random_of_3==2):
		question_label.text="volume qs"
	else:
		question_label.text="conc qs"
