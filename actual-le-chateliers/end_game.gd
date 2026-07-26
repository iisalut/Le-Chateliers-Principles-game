extends Control

@onready var game_over_text_2: RichTextLabel = $"game over text2"
@onready var replay_button: Button = $"replay button"
@onready var confetti_particles: Node2D = $"confetti particles"
@onready var prof_mad_1: TextureRect = $"prof mad1"
@onready var prof_mad_2: TextureRect = $"prof mad2"
@onready var prof_2: TextureRect = $prof2
@onready var prof_1: TextureRect = $prof1


func _ready():
	game_over_text_2.text="Final Score: "+str(QsData.score)+" / 20"
	prof_1.hide()
	prof_2.hide()
	confetti_particles.hide()
	if QsData.score>10:
		prof_mad_1.hide()
		prof_mad_2.hide()
		confetti_particles.show()
		prof_1.show()
		prof_2.show()


func _on_replay_button_pressed() -> void:
	QsData.full_finished_qs=[]
	QsData.temp_finished_qs=[]
	QsData.conc_finished_qs=[]
	QsData.vol_finished_qs=[]
	QsData.score=0
	get_tree().change_scene_to_file("res://quiz.tscn")
