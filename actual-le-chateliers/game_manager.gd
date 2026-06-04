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
var qs_type=1 # first qs always temp BUT keeps track of which qs type (temp,vol,conc)
var curr_qs="" # current question

#---temp variables and functions-----
var random_select_temp= randi_range(0,5) # random var to choose in temp dict
var curr_enthalpy="" #current enthalpy 
var heat_added= randf()<0.5 # boolean value that manages the heat added/ removed aspect
var can_temp_activate= true

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
	validate_qs(curr_qs,qs_type)
	question_label.text= curr_qs
	enthalpy_label.text="ΔH : "+curr_enthalpy
	heat_added= randf()<0.5
	if(heat_added==true):
		question_description.text="If the temperature of the system is increased, how will the equilibrium shift?"
	else:
		question_description.text="If the system is cooled down, how will the equilibrium shift?"
	

#--------------------

#---vol variables and functions-----
var random_select_vol= randi_range(0,6)
var curr_max_vol_moles=""
var vol_inc= 0.5<randf()
var can_vol_activate= true


func choose_vol_qs():
	var inner_dict= QsData.vol_qs_dict[random_select_vol]
	for rxn in inner_dict:
		curr_qs=rxn
		curr_max_vol_moles= inner_dict[rxn]

func check_vol_ans(value: float) -> void:
	if(vol_inc):
		if curr_max_vol_moles=="right" and value>0 :
			answer_label.text="Correct vol!"
			score+=1
		elif curr_max_vol_moles=="left" and value<0:
			answer_label.text="Correct vol"
			score+=1
		else:
			answer_label.text="Wrong :("
	else:
		if curr_max_vol_moles=="right" and value<0 :
			answer_label.text="Correct vol!"
			score+=1
		elif curr_max_vol_moles=="left" and value>0:
			answer_label.text="Correct vol"
			score+=1
		else:
			answer_label.text="Wrong :("
	score_label.text= "Score:"+str(score)

func display_vol():
	vol_inc= 0.5<randf()
	random_select_vol= randi_range(0,6)
	choose_vol_qs()
	validate_qs(curr_qs,qs_type)
	question_label.text=curr_qs
	if (vol_inc==true):
		question_description.text="If the volume of the reaction vessel is INCREASED, which way will the equillibrium shift ?"
	else:
		question_description.text="If the volume of the reaction vessel is DECREASED, which way will the equillibrium shift ?"

#-------------------------------------------------------------------------------------
func validate_qs(current_qs, question_type): 
	# takes curr_qs and question_type figures out what type of question.
	# if the chosen qs not in the finished_dict then that is the final chosen question and it is added to the finished_dict
	# if the chosen qs is in the finished_dict then the func runs again till a new qs is chosen 
					
		if question_type==1 and can_temp_activate:
			while true:
				if(!QsData.temp_finished_qs.has(current_qs)):
					curr_qs=current_qs
					QsData.temp_finished_qs.append(curr_qs)
					QsData.full_finished_qs.append(curr_qs)
					print(" finished_temp: "+ str(QsData.full_finished_qs))
					if QsData.temp_finished_qs.size()==6: # need to update this num everytime change num qs
						can_temp_activate=false
					break
				else:
					if QsData.temp_finished_qs.size()==6: # need to update this num everytime change num qs
						can_temp_activate=false
						break
					choose_temp_qs()
					current_qs=curr_qs
		
		elif question_type==2 and can_vol_activate :
			while true:
				if(!QsData.vol_finished_qs.has(current_qs)):
					curr_qs=current_qs
					QsData.vol_finished_qs.append(curr_qs)
					QsData.full_finished_qs.append(curr_qs)
					print(" finished_vol: "+ str(QsData.full_finished_qs))
					if QsData.vol_finished_qs.size()==7: # need to update this num everytime change num qs
						can_vol_activate=false
					break
				else:
					if QsData.vol_finished_qs.size()==7: # need to update this num everytime change num qs
						can_vol_activate=false
						break
					choose_vol_qs()
					current_qs=curr_qs
		else:
			pass

func _ready():
	display_temp()
	


func _on_submit_button_pressed() -> void: # displays answer label
	var slider_value= slider.value
	if (qs_type== 1):
		check_temp_ans(slider_value)
	elif (qs_type==2):
		check_vol_ans(slider_value)
	else:
		pass #conc

func _on_button_pressed() -> void: # loads in new qs type out of 3 total
	
	enthalpy_label.text=""
	question_description.text=""
	answer_label.text=""
	qs_type= randi_range(1,3)

	#if (qs_type== 1 ):
	#	display_temp()
	#elif (qs_type==2):
	#	display_vol()
	#else:
	#	question_label.text="conc qs"
	
	match qs_type:	
		1: 
			if (can_temp_activate):
				display_temp()
			else:
				_on_button_pressed()
		2:
			if (can_vol_activate):
				display_vol()
			else:
				_on_button_pressed()
		3:
			pass
			
