Controls { meshengine="snmesh" }

# (20 20 2) with (10 10 0.1) output 50w+ + 80w-

# added others to see the effect
Definitions {

        Refinement "global" {
                MaxElementSize = (100 100 5)
                MinElementSize = (10 10 0.1)
								RefineFunction = MaxTransDiff(Variable = "DopingConcentration", Value = 1)
				}
				Refinement "others" {
								MaxElementSize = (20 20 2)
								MinElementSize = (10 10 0.1)
				}

				Constant "const" {
								Species = "BoronActiveConcentration"
								Value = 5.e12
				}

  SubMesh "tmpplane" {
    Geofile = "n@node|sprocess@_fps.tdr"
  }

}

Placements {

	Constant "const" {
		Reference = "const" 
		EvaluateWindow {
			Element = Cuboid[(-650 0 0) (650 1300 -50)]
			DecayLength = 0.
		}
	}

  SubMesh "place_tmpplane_r1" {
  Reference = "tmpplane"
  ShiftVector = (0 0 0)
  Rotation {
    angle = 90
    axis  = Y
  } 
  Rotation {
    angle = 0
    axis  = Z
  } 
	ShiftVector = (-475 0 0)
	EvaluateWindow {
		Element = sweepElement {
			base = rectangle [ (-475 0 0) , (-475 1300 -50) ]
			path = [ (-475, 0, 0) (475, 0, 0) ]
		}
	}
	Replace
}
	SubMesh "place_tmpplane_r2" {
		Reference = "tmpplane"
		Rotation {
			angle = 90
			axis = Y
		}
		ShiftVector = (475 0 0)
	
		EvaluateWindow {
			Element = sweepElement {
				base = rectangle [ (475 0 0) , (475 175 -50) ]
				point = (475, 175, 0)
				axis = (0, 0, 1)
				angle = 90
			}
		}
		Replace
	}
	SubMesh "place_tmpplane_r3" {
		Reference = "tmpplane"
		Rotation {
			angle = 90
			axis = Y
		}
		Rotation {
			angle = 90
			axis = Z
		}
		ShiftVector = (650 0 0)
		ShiftVector = (0 1125 0)
	
		EvaluateWindow {
			Element = sweepElement {
				base = rectangle [ (475 1125 0) , (650 1125 -50) ]
				point = (475, 1125, 0)
				axis = (0, 0, 1)
				angle = 90
			}
		}
		Replace
	}
	SubMesh "place_tmpplane_r4" {
		Reference = "tmpplane"
		Rotation {
			angle = 90
			axis = Y
		}
		ShiftVector = (-475 0 0)
	
		EvaluateWindow {
			Element = sweepElement {
				base = rectangle [ (-475 0 0) , (-475 175 -50) ]
				point = (-475, 175, 0)
				axis = (0, 0, 1)
				angle = -90
			}
		}
		Replace
	}
	SubMesh "place_tmpplane_r5" {
		Reference = "tmpplane"
		Rotation {
			angle = 90
			axis = Y
		}
		Rotation {
			angle = -90
			axis = Z
		}
		ShiftVector = (-650 0 0)
		ShiftVector = (0 1124 0)
	
		EvaluateWindow {
			Element = sweepElement {
				base = rectangle [ (-474 1124 0) , (-650 1124 -50) ]
				point = (-474, 1124, 0)
				axis = (0, 0, 1)
				angle = -90
			}
		}
		Replace
	}
	SubMesh "place_tmpplane_r6" {
		Reference = "tmpplane"
		Rotation {
			angle = 90
			axis = Y
		}
		Rotation {
			angle = 90
			axis = Z
		}
		ShiftVector = (650 0 0)
		ShiftVector = (0 175 0)
	
		EvaluateWindow {
			Element = sweepElement {
				base = rectangle [ (650 175 0) , (-650 175 -50) ]
				path = [ (0, 175, 0) (0, 1125, 0) ]
			}
		}
		Replace
	}


	Refinement "global" {
		Reference = "global"
		RefineWindow=Material["Silicon"]
	}
	Refinement "Al" {
		Reference = "others"
		RefineWindow=Material["Aluminum"]
	}
	Refinement "Oxide" {
		Reference = "others"
		RefineWindow=Material["Oxide"]
	}
	Refinement "Nitride" {
		Reference = "others"
		RefineWindow=Material["Nitride"]
	}

}



