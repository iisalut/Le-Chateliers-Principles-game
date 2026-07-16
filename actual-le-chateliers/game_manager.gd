extends Control


@onready var question_label: RichTextLabel = $question_label
@onready var button: Button = $Button
@onready var enthalpy_label: RichTextLabel = $enthalpy_label
@onready var slider: HSlider = $"slider stuff/slider"
@onready var submit_button: Button = $submit_button
@onready var answer_label: RichTextLabel = $answer_label
@onready var score_label: RichTextLabel = $"static stuff/score_label"
@onready var question_description: RichTextLabel = $question_description
@onready var line_edit: LineEdit = $LineEdit
@onready var kc_label: RichTextLabel = $"Kc label"
@onready var qc_value_description: RichTextLabel = $"static stuff/Qc value description"



#--- conc dict-------
var conc_num1=0
var conc_num2=0
var conc_num3=0
var conc_num4=0

#--------------------------

var score=0 
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
	random_select_temp= randi_range(0,5)
	var inner_dict=QsData.temp_qs_dict[random_select_temp]
	for rxn in inner_dict :
		
		curr_qs= rxn
		curr_enthalpy=inner_dict[rxn]
	print("choosing new temp qs")

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
	print("just checked answer and updated score")
func display_temp(): # Displays temp labels
	
	choose_temp_qs() # uses helper
	validate_qs(curr_qs,qs_type)
	question_label.text= curr_qs
	enthalpy_label.text="ΔH : "+curr_enthalpy
	heat_added= randf()<0.5
	if(heat_added==true):
		question_description.text="If the temperature of the system is increased, how will the equilibrium shift?"
	else:
		question_description.text="If the system is cooled down, how will the equilibrium shift?"
		
	print(" description added for temp  qs")


#--------------------

#---vol variables and functions-----
var random_select_vol= randi_range(0,6)
var curr_max_vol_moles=""
var vol_inc= 0.5<randf()
var can_vol_activate= true


func choose_vol_qs():
	random_select_vol= randi_range(0,6)
	var inner_dict= QsData.vol_qs_dict[random_select_vol]
	for rxn in inner_dict:
		curr_qs=rxn
		curr_max_vol_moles= inner_dict[rxn]
	print("choosing new vol qs")

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
	print("just checked answers and updated score")

func display_vol():
	choose_vol_qs()
	validate_qs(curr_qs,qs_type)
	question_label.text=curr_qs
	vol_inc= 0.5<randf()
	if (vol_inc==true):
		question_description.text="If the volume of the reaction vessel is INCREASED, which way will the equillibrium shift ?"
	else:
		question_description.text="If the volume of the reaction vessel is DECREASED, which way will the equillibrium shift ?"
		print(" description added for vol  qs")
#-------------------------------------------------------------------------------

#---conc variables and functions-----
var random_select_conc=randi_range(0,6)
var curr_Kc=""
var corr_Qc=0

var can_conc_activate= true
func correct_Qc_calculation(): # need to update this for every added conc qs
	match random_select_conc:
		0: 
			corr_Qc = (pow(conc_num3, 2) / (conc_num1 * pow(conc_num2, 3)))
		1:
			corr_Qc = (conc_num3 / (conc_num1 * conc_num2))
		2:
			corr_Qc = (pow(conc_num2, 2) / conc_num1)
		3:
			corr_Qc = (pow(conc_num3, 2) / (conc_num1 * conc_num2))
		4:
			corr_Qc = (pow(conc_num3, 2) / (pow(conc_num1, 2) * conc_num2))
		5:
			corr_Qc = ((conc_num3 * conc_num2) / conc_num1)
		6:
			corr_Qc = ((conc_num3 * conc_num4) / (conc_num1 * conc_num2))

func choose_conc_qs():  # the conc dictionary is in here
	random_select_conc=randi_range(0,6)
	conc_num1=snapped(randf_range(0.10,10.0),0.001)
	conc_num2=snapped(randf_range(0.10,10.0),0.001)
	conc_num3=snapped(randf_range(0.10,10.0),0.001)
	conc_num4=snapped(randf_range(0.10,10.0),0.001)
	
	
	var conc_qs_dict={ 
		0: {str(conc_num1)+"M N₂ + "+ str(conc_num2)+ "M 3 H₂ ⇌ "+str(conc_num3)+ "M 2 NH₃": 275.0}, 
		1:{str(conc_num1)+"M CO + "+str(conc_num2)+"M Cl₂ ⇌ "+str(conc_num3)+"M COCl₂": 5.0}, 
		2:{str(conc_num1)+"M N₂O₄ ⇌ "+str(conc_num2)+"M 2 NO₂": 0.0046}, 
		3:{str(conc_num1)+"M H₂ + "+str(conc_num2)+"M I₂ ⇌ "+str(conc_num3)+"M 2 HI":54.0}, 
		4:{str(conc_num1)+"M 2 SO₂ + "+str(conc_num2)+"M O₂ ⇌ "+str(conc_num3)+"M 2 SO₃":4.3 }, # FIX 3: Added pow(conc_num1, 2) to match 2 SO₂
		5:{str(conc_num1)+"M PCl₅ ⇌ "+str(conc_num2)+"M PCl₃ + "+str(conc_num3)+"M Cl₂": 0.042}, 
		6:{str(conc_num1)+"M CO + "+str(conc_num2)+"M H₂O ⇌ "+str(conc_num3)+"M CO₂ + "+str(conc_num4)+"M H₂":1.0} 
	}
	
	
	var inner_dict=conc_qs_dict[random_select_conc]
	for rxn in inner_dict:
		curr_qs=rxn
		curr_Kc= inner_dict[rxn]
	correct_Qc_calculation()
	print("choosing new conc qs")
	print(" num1: "+str(conc_num1)+" num2: "+str(conc_num2)+" num3: "+str(conc_num3)+" num4: "+str(conc_num4))
	print("current Kc "+str(curr_Kc))


var actual_final_ans_qc=0.0
func sig_fig_fixer(corr_Qc, sig_fig_num: int):
	var corr_Qc_string_final=" "	
	var corr_Qc_string_form=str(corr_Qc)
	var valid_sig_figs_counter=0
	var adjacent_element=""
	var first_sf_valid=false
	var current_index=0
	
	for i in corr_Qc_string_form:
		if valid_sig_figs_counter< sig_fig_num:
			if first_sf_valid==false and (i=="0" or i=="."):
				corr_Qc_string_final+=i
				print("current Qc string:"+corr_Qc_string_final)
			else:
				first_sf_valid=true
				print("no more trailing zero's ! valid sf activated")
				valid_sig_figs_counter+=1
				corr_Qc_string_final+=i
				print("current Qc string:"+corr_Qc_string_final)
				adjacent_element= corr_Qc_string_form[current_index+1]
		current_index+=1
		print("sf iteration: "+str(valid_sig_figs_counter))
	corr_Qc_string_final+=adjacent_element
	print("before rounding number:"+corr_Qc_string_final)	
	#rounding part----
	var actual_final_ans_qc
	var splice_length= 	(corr_Qc_string_final.get_slice(".",1)).length()
	print("splice length:"+ str(splice_length))
	var base_number = float(corr_Qc_string_final)
	print("base_number:"+ str(base_number))
	var multiplier = pow(10, splice_length - 1)
	print("multiplier:"+ str(multiplier))
	var shifted_number = base_number * multiplier
	print("shifted_number:"+ str(shifted_number))
	actual_final_ans_qc = floor(shifted_number + 0.5)
	print("actual_final_ans_qc"+ str(actual_final_ans_qc))
	return actual_final_ans_qc

func check_conc_ans( user_Qc: String,value: float):
	var float_Qc=float(user_Qc)
	corr_Qc=snapped(corr_Qc,0.000001)
	var final_corr_Qc=sig_fig_fixer(corr_Qc,3)
	print("correct Qc is "+str(final_corr_Qc))
	if(corr_Qc>curr_Kc):
		print("right now "+str(final_corr_Qc)+" > "+str(curr_Kc))
		if((final_corr_Qc==float_Qc) and (value<0)):
			answer_label.text="correct ! both value"
			score+=1
		elif(final_corr_Qc==float_Qc):
			answer_label.text="slider value wrong"
		elif(value<0):
			answer_label.text="Qc value wrong"
		else:
			answer_label.text="Slider and Qc values wrong"
	else:
		if(corr_Qc<curr_Kc):
			print("right now "+str(final_corr_Qc)+" < "+str(curr_Kc))
			if((final_corr_Qc==float_Qc) and (value>0)):
				answer_label.text="correct ! both value"
				score+=1
			elif(final_corr_Qc==float_Qc):
				answer_label.text="slider value wrong"
			elif(value>0):
				answer_label.text="Qc value wrong."
			else:
				answer_label.text="Slider and Qc values wrong"	
	score_label.text= "Score:"+str(score)
	
func display_conc():
	choose_conc_qs()
	validate_qs(curr_qs,qs_type)
	line_edit.show()
	question_label.text=curr_qs
	kc_label.text="Kc value: "+str(curr_Kc)
	question_description.text="Calculate Qc and predict how the equilibrium will shift based on the Qc and Kc value"
	qc_value_description.text="Enter Qc value"
#----------------------------------------
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
					print("validate temp just ran")
					if QsData.temp_finished_qs.size()==6: # need to update this num everytime change num qs
						can_temp_activate=false
						print("all temp qs over")
					break
				else:
					if QsData.temp_finished_qs.size()==6: # need to update this num everytime change num qs
						can_temp_activate=false
						print("all temp qs over")
						break
					choose_temp_qs()
					print("need to find another question")
					current_qs=curr_qs
		
		elif question_type==2 and can_vol_activate :
			while true:
				if(!QsData.vol_finished_qs.has(current_qs)):
					curr_qs=current_qs
					QsData.vol_finished_qs.append(curr_qs)
					QsData.full_finished_qs.append(curr_qs)
					print(" finished_vol: "+ str(QsData.full_finished_qs))
					print("validate vol just ran")
					if QsData.vol_finished_qs.size()==7: # need to update this num everytime change num qs
						can_vol_activate=false
						print("all vol qs over")
					break
				else:
					if QsData.vol_finished_qs.size()==7: # need to update this num everytime change num qs
						can_vol_activate=false
						print("all vol qs over")
						break
					choose_vol_qs()
					print("need to find another question")
					current_qs=curr_qs
		else:
			while true:
				if(!QsData.conc_finished_qs.has(current_qs)):
					curr_qs=current_qs
					QsData.conc_finished_qs.append(curr_qs)
					QsData.full_finished_qs.append(curr_qs)
					print(" finished_conc: "+ str(QsData.full_finished_qs))
					print("validate conc just ran")
					if QsData.conc_finished_qs.size()==7: # need to update this num everytime change num qs
						can_conc_activate=false
						print("all conc qs over")
					break
				else:
					if QsData.conc_finished_qs.size()==7: # need to update this num everytime change num qs
						can_conc_activate=false
						print("all conc qs over")
						break
					choose_conc_qs()
					print("need to find another question")
					current_qs=curr_qs

func _ready():
	line_edit.hide()
	display_temp()
	print(" num1: "+str(conc_num1)+" num2: "+str(conc_num2)+" num3: "+str(conc_num3)+" num4: "+str(conc_num4))

var submit_click_count=0
func _on_submit_button_pressed() -> void: # displays answer label
	var slider_value= slider.value
	submit_click_count+=1
	if (qs_type== 1):
		check_temp_ans(slider_value)
		$submit_button.disabled=true
	elif (qs_type==2):
		check_vol_ans(slider_value)
		$submit_button.disabled=true
	else:	
		check_conc_ans(line_edit.text,slider_value)
		print("submit btn click count for qs type 3: "+str(submit_click_count))
		if submit_click_count>=2:
			$submit_button.disabled=true

func _on_button_pressed() -> void: # loads in new qs type out of 3 total
	
	$submit_button.disabled=false
	line_edit.hide()
	enthalpy_label.text=""
	question_description.text=" "
	answer_label.text=""
	line_edit.text=" "
	kc_label.text=" "
	qc_value_description.text=" "
	qs_type= randi_range(1,3)

	print("next qs button pressed")
	if not can_temp_activate and not can_vol_activate and not can_conc_activate:
		question_label.text = "Game Over! All questions completed."
		enthalpy_label.text = ""
		question_description.text = " "
		qc_value_description.text=" "
		answer_label.text = ""
		return
		
	
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
			if (can_conc_activate):
				display_conc()
			else:
				_on_button_pressed()
