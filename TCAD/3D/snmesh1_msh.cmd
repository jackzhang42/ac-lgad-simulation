Controls { meshengine="snmesh" }

AxisAligned {
	
 smoothing = false

}

Definitions {

				Refinement "Silicon" {
								MaxElementSize = (150 150 10)
								MinElementSize = (50 50 2)
								RefineFunction = MaxTransDiff(Variable = "DopingConcentration", Value = 4)
#								RefineFunction = MaxGradient(Variable = "DopingConcentration", Value = 10);
				}

				Refinement "doping_side" {
								MaxElementSize = (100 100 2)
								MinElementSize = (1 1 0.1)
#								RefineFunction = MaxGradient(Variable = "DopingConcentration", Value = 10);
								RefineFunction = MaxTransDiff(Variable = "DopingConcentration", Value = 4)
				}

        Refinement "body" {
                MaxElementSize = (100 100 10)
								MinElementSize = (2 2 0.1)
								RefineFunction = MaxTransDiff(Variable = "DopingConcentration", value = 2)
				}
				Refinement "doping_center" {
#								MaxElementSize = (100 100 0.5)
#								MinElementSize = (80 80 0.2)
								MaxElementSize = (100 100 1)
								MinElementSize = (50 50 0.1)
								RefineFunction = MaxTransDiff(Variable = "DopingConcentration", Value = 4)
				}
				Refinement "doping_corner" {
								MaxElementSize = (50 50 0.5)
#								MinElementSize = (10 10 0.2)
								MinElementSize = (5 5 0.1)
								RefineFunction = MaxTransDiff(Variable = "DopingConcentration", Value = 10)
				}
				Refinement "bottom" {
								MaxElementSize = (100 100 1)
								MinElementSize = (50 50 0.1)
								RefineFunction = MaxTransDiff(Variable = "DopingConcentration", Value = 4)
				}
				Refinement "Aluminum" {
								MaxElementSize = (20 20 0.2)
								MinElementSize = (10 10 0.1)
				}
				Refinement "SiO2" {
								MaxElementSize = (20 20 0.2)
								MinElementSize = (10 10 0.1)
				}
				Refinement "Si3N4" {
								MaxElementSize = (20 20 0.02)
								MinElementSize = (10 10 0.01)
				}


#  SubMesh "tmpplane" {
#    Geofile = "n@node|sprocess@_fps.tdr"
#  }

				SubMesh "doping" {
					Geofile = "n@node|-1@_msh.tdr"
				}
}

Placements {

#		SubMesh "place_tmpplane_r1" {
#		Reference = "tmpplane"
#		Rotation {
#			angle = 90
#			axis = Y
#		}
#		Rotation {
#			angle = 90
#			axis = Z
#		}
#		ShiftVector = (650 0 0)
#		ShiftVector = (0 1125 0)
#		EvaluateWindow {
#			Element = sweepElement {
#				base = rectangle [ (475 1125 0) , (650 1125 -50) ]
#				point = (475, 1125, 0)
#				axis = (0, 0, 1)
#				angle = 90
#			}
#		}
#		Replace
#	}
#	SubMesh "place_tmpplane_r2" {
#		Reference = "tmpplane"
#		Rotation {
#			angle = 90
#			axis = Y
#		}
#		Rotation {
#			angle = 0
#			axis = Z
#		}
#		ShiftVector = (0 0 0)
#		ShiftVector = (0 0 0)
#		EvaluateWindow {
#			Element = sweepElement {
#				base = rectangle [ (0 0 0), (0 1300 -50) ]
#				path = [ (0, 0, 0) (-650, 0, 0) ]
#			}
#		}
#		Replace
#	}
	SubMesh "final" {
		Reference = "doping"
		SelectWindow {
			AttachPoint = (0 0 0)
			ToPoint = (0 0 0)
		}
		EvaluateWindow {
			Element = cuboid [ (-650 0 0), (650 1300 -50) ]
		}
	}

	SubMesh "rot" {
		Reference = "doping"
		Rotation {
			angle = 90
			axis = Z
		}
		SelectWindow {
			AttachPoint = (0 0 0)
			ToPoint = (650 650 0)
		}
		EvaluateWindow {
			Element = cuboid [ (-475 1125 0), (-650 1300 -50) ] 
		}
		Replace
	}

#	Refinement "body" {
#		Reference = "body"
#		RefineWindow=cuboid[(650 0 -5), (-650 1300 -48)]
#	}
	Refinement "bottom" {
		Reference = "bottom" 
		RefineWindow=cuboid[(650 0 -48), (-650 1300 -50)]
	}
	Refinement "doping_center" {
		Reference = "doping_center"
		RefineWindow=cuboid[(450 200 0), (-450 1100 -5)]
}
  Refinement "doping_side_1" {
		Reference = "doping_side"
		RefineWindow=cuboid[(400 0 0), (650 1100 -8)]
	}  
	Refinement "doping_side_2" {
		Reference = "doping_side"
		RefineWindow=cuboid[(650 1100 0), (-400 1300 -8)]
	}
  Refinement "doping_side_3" {
		Reference = "doping_side"
		RefineWindow=cuboid[(-400 1300 0), (-650 200 -8)]
	}
  Refinement "doping_side_4" {
		Reference = "doping_side"
		RefineWindow=cuboid[(-650 200 0), (450 0 -8)]
	}

	Refinement "Silicon" {
		Reference = "Silicon"
		RefineWindow=cuboid[(-650 0 -5), (650 1300 -48)]
	}
#	Refinement "Aluminum" {
#		Reference = "Aluminum"
#		RefineWindow = Material["Aluminum"]
#	}
#	Refinement "SiO2" {
#		Reference = "SiO2" 
#		RefineWindow = Material["SiO2"]
#	}
#	Refinement "Si3N4" {
#		Reference = "Si3N4"
#		RefineWindow = Material["Si3N4"]
#	}
}

