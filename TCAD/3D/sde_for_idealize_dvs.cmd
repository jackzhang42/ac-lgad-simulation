(sde:clear)

(define xlow 0.0)
(define xhigh 50.0)
(define ylow 0.0)
(define yhigh 1300.0)

(define npad 5)
(define gap 75.0)
(define side 100.0)

(define ljte 25.0)
(define metalext 15.0)
(define tox 1.0)
(define tdiel 0.1)
(define tmetal 1.0)
(define pstopwidth 20)
(define pstoptojte 30)
(define grwidth 60)
(define pstoptogr 30)
(define grext 16)
(define lnp (+ (+ (* (+ 1 npad) gap) (* npad side)) (* 2 tmetal)))

(define npleft (/ (- yhigh lnp) 2))
(define npright (- yhigh npleft))
(define jte1left (- npleft (/ ljte 2)))
(define jte1right (+ npleft (/ ljte 2)))
(define jte2left (- npright (/ ljte 2)))
(define jte2right (+ npright (/ ljte 2)))
(define metalleft (- npleft metalext))
(define metalright (+ npright metalext))

(define pstop1right (- jte1left pstoptojte))
(define pstop1left (- pstop1right pstopwidth))
(define pstop2left (+ jte2right pstoptojte))
(define pstop2right (+ pstop2left pstopwidth))

(define gr1right (- pstop1left pstoptogr))
(define gr1left (- gr1right grwidth))
(define gr2left (+ pstop2right pstoptogr))
(define gr2right (+ gr2left grwidth))

(define gr1leftext (- gr1left grext))
(define gr1rightext (+ gr1right grext))
(define gr2leftext (- gr2left grext))
(define gr2rightext (+ gr2right grext))

(define acleft (+ npleft tmetal))
(define acright (- npright tmetal))

(define npp1left (- npleft 1))
(define npp1right (+ acleft 1))
(define npp2left (- acright 1))
(define npp2right (+ npright 1))

(sdegeo:set-default-boolean "ABA")
(sdegeo:create-rectangle (position xlow ylow 0) (position xhigh yhigh 0) "Silicon" "R.substrate")
(sdegeo:create-rectangle (position xhigh ylow 0) (position (+ xhigh tmetal) yhigh 0) "Aluminum" "R.cathode")
(sdegeo:create-rectangle (position xlow ylow 0) (position (- xlow tox) acleft 0) "Oxide" "R.oxide_left")
(sdegeo:create-rectangle (position xlow acright 0) (position (- xlow tox) yhigh 0) "Oxide" "R.oxide_right")

(sdegeo:create-polygon (list (position (- xlow (+ tox tmetal)) metalleft 0) (position (- xlow (+ tox tmetal)) acleft 0) 
 (position xlow acleft 0) (position xlow npleft 0) (position (- xlow tox) npleft 0) (position (- xlow tox) metalleft 0)
 (position (- xlow (+ tox tmetal)) metalleft 0)) "Aluminum" "R.anode_left")

(sdegeo:create-polygon (list (position (- xlow (+ tox tmetal)) metalright 0) (position (- xlow (+ tox tmetal)) acright 0) 
 (position xlow acright 0) (position xlow npright 0) (position (- xlow tox) npright 0) (position (- xlow tox) metalright 0)
 (position (- xlow (+ tox tmetal)) metalright 0)) "Aluminum" "R.anode_right")

(sdegeo:create-rectangle (position xlow acleft 0) (position (- xlow tdiel) acright 0) "Si3N4" "R.nitride")

(sdegeo:create-polygon (list 
	(position (- xlow (+ tox tmetal)) gr1leftext 0) (position (- xlow (+ tox tmetal)) (+ gr1left 1) 0) 
	(position (- xlow tox) (+ gr1left 1) 0) (position (- xlow tox) (- gr1right 1) 0) 
	(position (- xlow (+ tox tmetal)) (- gr1right 1) 0)	(position (- xlow (+ tox tmetal)) gr1rightext 0)
	(position (- xlow tox) gr1rightext 0) (position (- xlow tox) gr1right 0)
	(position xlow gr1right 0) (position xlow gr1left 0)
	(position (- xlow tox) gr1left 0) (position (- xlow tox) gr1leftext 0)
	(position (- xlow (+ tox tmetal)) gr1leftext 0)
												)
	"Aluminum" "R.gr_left"
 )
(sdegeo:create-polygon (list 
	(position (- xlow (+ tox tmetal)) gr2leftext 0) (position (- xlow (+ tox tmetal)) (+ gr2left 1) 0) 
	(position (- xlow tox) (+ gr2left 1) 0) (position (- xlow tox) (- gr2right 1) 0) 
	(position (- xlow (+ tox tmetal)) (- gr2right 1) 0)	(position (- xlow (+ tox tmetal)) gr2rightext 0)
	(position (- xlow tox) gr2rightext 0) (position (- xlow tox) gr2right 0)
	(position xlow gr2right 0) (position xlow gr2left 0)
	(position (- xlow tox) gr2left 0) (position (- xlow tox) gr2leftext 0)
	(position (- xlow (+ tox tmetal)) gr2leftext 0)
												)
	"Aluminum" "R.gr_right"
 )

(sdeio:save-tdr-bnd (get-body-list) "n@node@_bnd.tdr")
