extends Node


var temp_qs_dict={ 
0: {"CH₄ + 2 O₂ --> CO₂ + 2 H₂O" :"Exothermic"},
1:{"HCl + NaOH --> NaCl + H₂O": "Exothermic"},
2:{"C₆H₁₂O₆ +6 O₂ --> 6 CO₂ + 6 H₂O" :"Exothermic"},
3:{"6 CO₂ + 6 H₂O --> C₆H₁₂O₆ + 6 O₂" : "Endothermic"},
4:{"CaCO₃ --> CaO + CO₂" : "Endothermic"},
5:{"NH₄NO₃ --> NH⁴⁺ + NO³" : "Endothermic"}
}

var vol_qs_dict={ 
0: {"N₂ + 3 H₂ --> 2 NH₃": "left"},
1:{"2 SO₂ + O₂ --> 2 SO₃": "left"},
2:{"N₂O₄ --> 2 NO₂": "right"},
3:{"C₂H₂ + 2 H₂ --> C₂H₆ ":"left"},
4:{"CO  + 3 H₂  --> CH₄ + H₂O ":"left"},
5:{"CH₄ + H₂O --> CO + 3 H₂ ": "right"},
6:{"PCl₅ --> PCl₃ + Cl₂ ":"right"}
}

var full_finished_qs=[]
var temp_finished_qs=[]
var conc_finished_qs=[]
var vol_finished_qs=[]

static var score=0 
