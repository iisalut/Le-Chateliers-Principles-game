extends Node


var temp_qs_dict={ 0: {"CH4 + 2 O₂ ⇌ CO₂ + 2 H₂O" :"exothermic"},
1:{"HCl + NaOH ⇌ NaCl + H₂O": "exothermic"},
2:{"C₆H₁₂O₆ +6 O₂ ⇌ 6 CO₂ + 6 H₂O" :"exothermic"},
3:{"6 CO₂ + 6 H₂O ⇌ C₆H₁₂O₆ + 6 O₂" : "endothermic"},
4:{"CaCO₃ ⇌ CaO + CO₂" : "endothermic"},
5:{"NH4NO₃ ⇌ NH⁴⁺ + NO³⁻" : "endothermic"}
}

var vol_qs_dict={ 0: {"N₂ (g) + 3 H₂ (g) ⇌ 2 NH₃ (g) ": "left"},
1:{"2 SO₂ (g)+ O₂ (g) ⇌ 2 SO₃ (g) ": "left"},
2:{"N₂O4 (g) ⇌ 2 NO₂(g)": "right"},
3:{"C₂H₂(g) + 2 H₂(g) ⇌ C₂H₆ (g)":"left"},
4:{"CO (g) + 3 H₂ (g) ⇌ CH4 (g) + H₂O (g)":"left"},
5:{"CH4 (g) + H₂O (g) ⇌ CO (g) + 3 H₂ (g)": "right"},
6:{"PCl5 (g) ⇌ PCl₃ (g) + Cl₂ (g)":"right"}
}


var full_finished_qs=[]
var temp_finished_qs=[]
var conc_finished_qs=[]
var vol_finished_qs=[]
	
