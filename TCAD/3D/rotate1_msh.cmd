Controls { meshengine="snmesh" }


File {
	Grid = "@tdr@"
}

Definitions {

        Refinement "global" {
                MaxElementSize = (5 20 20)
                MinElementSize = (5 10 10)
       }


  SubMesh "tmpplane" {
    Geofile = "n@node|sprocess@_fps.tdr"
  }

}

Placements {

	SubMesh "place_tmpplane_r2" {
		Reference = "tmpplane"
		ShiftVector = (0 0 0)
		EvaluateWindow {
			Element = sweepElement {
				base = rectangle [ (0 0 0) , (50 175 0) ]
				point = (0, 175, 0)
				axis = (1, 0, 0)
				angle = -90
			}
		}
		Replace
	}


	Refinement "global" {
		Reference = "global"
		RefineWindow=Material["Silicon"]
	}

}

