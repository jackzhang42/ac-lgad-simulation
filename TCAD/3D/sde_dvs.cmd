(sde:clear)

(sdeio:read-tdr-bnd "n@node|-1@_bnd.tdr")

(define originalface (get-body-list))

(define scale 900.0)
(define gap 50.0)
(define size 200.0)
(define n 3)
(define pitch (/ scale n))
(define center_1 (+ (* 0.5 pitch) (* 0.5 gap)))
(define center_2 (+ center_1 pitch))
(define center_3 (+ center_2 pitch))

(define left_1 (- center_1 (/ size 2)))
(define right_1 (+ left_1 size))
(define left_2 (- center_2 (/ size 2)))
(define right_2 (+ left_2 size))
(define left_3 (- center_3 (/ size 2)))
(define right_3 (+ left_3 size))

(sdegeo:sweep originalface 475)
(sdegeo:set-default-boolean "ABA")

(define substrate (find-face-id (position 25 650 475)))
(define cathode (find-face-id (position 50.5 650 475)))

(define SiO2_left_1 (find-face-id (position -0.1 1 475)))
(define Al_left_1 (find-face-id (position -0.1 50 475)))
(define SiO2_left_2 (find-face-id (position -0.1 130 475)))
(define Al_left_2 (find-face-id (position -1.5 170 475)))

; (define SiO2_right_1 (find-face-id (position -0.1 1299 475)))
; (define SiO2_right_2 (find-face-id (position -0.1 1170 475)))
; (define Al_right_1 (find-face-id (position -0.1 1250 475)))
; (define Al_right_2 (find-face-id (position -1.5 1130 475)))

(sdegeo:sweep substrate 175)
(sdegeo:sweep cathode 175)

(sdegeo:chop-domain (list -5 -5 55 -5 55 655 -5 655))
(sdegeo:sweep SiO2_left_1 (position 0 175 475) (gvector 1 0 0)
 (sweep:options "solid" #t "sweep_angle" -90 "rigid" #f "miter_type" "default"))

(sdegeo:sweep SiO2_left_2 (position 0 175 475) (gvector 1 0 0)
 (sweep:options "solid" #t "sweep_angle" -90 "rigid" #f "miter_type" "default"))

(sdegeo:sweep Al_left_1 (position 0 175 475) (gvector 1 0 0)
 (sweep:options "solid" #t "sweep_angle" -90 "rigid" #f "miter_type" "default"))

(sdegeo:sweep Al_left_2 (position 0 175 475) (gvector 1 0 0)
 (sweep:options "solid" #t "sweep_angle" -90 "rigid" #f "miter_type" "default"))

; (sdegeo:sweep SiO2_right_1 (position 0 1125 475) (gvector 1 0 0)
;  (sweep:options "solid" #t "sweep_angle" 90 "rigid" #f "miter_type" "default"))

; (sdegeo:sweep SiO2_right_2 (position 0 1125 475) (gvector 1 0 0)
;  (sweep:options "solid" #t "sweep_angle" 90 "rigid" #f "miter_type" "default"))

; (sdegeo:sweep Al_right_1 (position 0 1125 475) (gvector 1 0 0)
;  (sweep:options "solid" #t "sweep_angle" 90 "rigid" #f "miter_type" "default"))

; (sdegeo:sweep Al_right_2 (position 0 1125 475) (gvector 1 0 0)
;  (sweep:options "solid" #t "sweep_angle" 90 "rigid" #f "miter_type" "default"))

(define SiO2_new_1 (find-face-id (position -0.1 175 649)))
(define SiO2_new_2 (find-face-id (position -0.1 175 520)))
(define Al_new_1 (find-face-id (position -0.1 175 600)))
(define Al_new_2 (find-face-id (position -1.5 175 480)))

(sdegeo:sweep SiO2_new_1 475)
(sdegeo:sweep SiO2_new_2 475)
(sdegeo:sweep Al_new_1 475)
(sdegeo:sweep Al_new_2 475)

; (sdegeo:sweep substrate 1300)
; (sdegeo:sweep surface 1000)
;(sdegeo:sweep substrate (position 0 0 0) (gvector 1 0 0) 
; (sweep:options "solid" #t "sweep_angle" 360 "rigid" #f "miter_type" "default"))
; (sdegeo:sweep-corner originalface (position 0 2000 0) (gvector 1 0 0))
; (sdegeo:sweep originalface -1300)

; (sdegeo:mirror-selected (find-body-id (position -0.1 175 649))
;  (transform:reflection (position -0.1 650 649) (gvector 0 1 0)) #t)

; (sdegeo:mirror-selected (find-body-id (position -0.1 175 520))
;  (transform:reflection (position -0.1 650 520) (gvector 0 1 0)) #t)

; (sdegeo:mirror-selected (find-body-id (position -0.1 175 600))
;  (transform:reflection (position -0.1 650 600) (gvector 0 1 0)) #t)

; (sdegeo:mirror-selected (find-body-id (position -1.5 175 480))
;  (transform:reflection (position -1.5 650 480) (gvector 0 1 0)) #t)

(sdegeo:mirror-selected (get-body-list)
 (transform:reflection (position 0 650 0) (gvector 0 1 0)) #t)

; define pads by sde
(define z_1 (- 475.0 left_1))
(define z_3 (- 475.0 right_1))
(define z_2 (- 475.0 left_2))

(define y_1_left (+ left_1 175))
(define y_2_left (+ left_2 175))
(define y_3_left (+ left_3 175))
(define y_1_right (+ right_1 175))
(define y_2_right (+ right_2 175))
(define y_3_right (+ right_3 175))

(sdegeo:create-cuboid (position -0.1 y_1_left z_1) (position -1.1 y_1_right z_3) "Aluminum" "R.pad1")
(sdegeo:create-cuboid (position -0.1 y_2_left z_1) (position -1.1 y_2_right z_3) "Aluminum" "R.pad2")
(sdegeo:create-cuboid (position -0.1 y_3_left z_1) (position -1.1 y_3_right z_3) "Aluminum" "R.pad3")
(sdegeo:create-cuboid (position -0.1 y_1_left z_2) (position -1.1 y_1_right 0) "Aluminum" "R.pad4")
(sdegeo:create-cuboid (position -0.1 y_2_left z_2) (position -1.1 y_2_right 0) "Aluminum" "R.pad5")
(sdegeo:create-cuboid (position -0.1 y_3_left z_2) (position -1.1 y_3_right 0) "Aluminum" "R.pad6")

(sdegeo:mirror-selected (get-body-list) 
 (transform:reflection (position 0 0 0) (gvector 0 0 -1)) #t)

; (sdegeo:define-work-plane "pads_plane" (position -0.1 175 175) (position 0 0 1) (position 0 1 0))
; (sdegeo:set-active-work-plane "pads_plane")
; (sdepe:generate-mask "pads" (list (list left_1 left_1 right_1 right_1) (list left_2 left_1 right_2 right_1)
;														  (list left_3 left_1 right_3 right_1) (list left_1 left_2 right_1 right_2)
;															 (list left_2 left_2 right_2 right_2) (list left_3 left_2 right_3 right_2)
;															  (list left_1 left_3 right_1 right_3) (list left_2 left_3 right_2 right_3)
;																 (list left_3 left_3 right_3 right_3)))
; (sdepe:pattern "mask" "pads" "polarity" "dark" "material" "Resist"
;  "thickness" 0.5)

; (sdepe:depo "material" "Aluminum" "thickness" 1.0 "type" "aniso")

(sde:add-material (find-body-id (position -1.0 y_1_left (- 0 z_1))) "Aluminum" "R.pad7")
(sde:add-material (find-body-id (position -1.0 y_2_left (- 0 z_1))) "Aluminum" "R.pad8")
(sde:add-material (find-body-id (position -1.0 y_3_left (- 0 z_1))) "Aluminum" "R.pad9")
(sde:add-material (find-body-id (position -0.1 650 600)) "Aluminum" "R.gr")
(sde:add-material (find-body-id (position -1.5 174 425)) "Aluminum" "R.anode")
(sde:add-material (find-body-id (position 25 650 0)) "Silicon" "R.substrate")
(sde:add-material (find-body-id (position 50.5 650 0)) "Aluminum" "R.cathode")
(sde:add-material (find-body-id (position -0.05 650 0)) "Nitride" "R.nitride")

(sdegeo:define-contact-set "pad_1" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "pad_2" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "pad_3" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "pad_4" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "pad_5" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "pad_6" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "pad_7" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "pad_8" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "pad_9" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "anode" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "gr" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "cathode" 4.0 (color:rgb 1.0 0.0 0.0) "##")

# (sdegeo:define-3d-contact (find-face-id (position -1.1 (* 0.5 (+ y_1_left y_1_right)) (* 0.5 (+ z_1 z_3)))) "pad_1")
(sdegeo:define-3d-contact (find-face-id (position -1.1 (* 0.5 (+ y_2_left y_2_right)) (* 0.5 (+ z_1 z_3)))) "pad_2")
(sdegeo:define-3d-contact (find-face-id (position -1.1 (* 0.5 (+ y_3_left y_3_right)) (* 0.5 (+ z_1 z_3)))) "pad_3")
(sdegeo:define-3d-contact (find-face-id (position -1.1 (* 0.5 (+ y_1_left y_1_right)) (* 0.5 (+ z_2 0)))) "pad_4")
(sdegeo:define-3d-contact (find-face-id (position -1.1 (* 0.5 (+ y_2_left y_2_right)) (* 0.5 (+ z_2 0)))) "pad_5")
(sdegeo:define-3d-contact (find-face-id (position -1.1 (* 0.5 (+ y_3_left y_3_right)) (* 0.5 (+ z_2 0)))) "pad_6")
(sdegeo:define-3d-contact (find-face-id (position -1.1 (* 0.5 (+ y_1_left y_1_right)) (- 0 (* 0.5 (+ z_1 z_3))))) "pad_7")
(sdegeo:define-3d-contact (find-face-id (position -1.1 (* 0.5 (+ y_2_left y_2_right)) (- 0 (* 0.5 (+ z_1 z_3))))) "pad_8")
(sdegeo:define-3d-contact (find-face-id (position -1.1 (* 0.5 (+ y_3_left y_3_right)) (- 0 (* 0.5 (+ z_1 z_3))))) "pad_9")
; (sdegeo:set-contact (find-body-id (position -1.5 650 480)) "anode")
; (sdegeo:set-contact (find-body-id (position -0.5 650 600)) "gr")
# (sdegeo:define-3d-contact (find-face-id (position 50 650 0)) "cathode")
; (sdegeo:set-contact (find-body-id (position 50.5 650 650)) "cathode")

(set-interface-contact "R.nitride" "R.pad1" "pad_1")
(set-interface-contact "R.substrate" "R.anode" "anode")
(set-interface-contact "R.substrate" "R.gr" "gr")
(set-interface-contact "R.substrate" "R.cathode" "cathode")

(sdegeo:rotate-selected (get-body-list) (transform:rotation (position 0 0 0) (gvector 0 1 0) 90))
(sdegeo:revolve (get-body-list) (position 0 0 0) (gvector 0 1 0) 90)

(sdeio:save-tdr-bnd (get-body-list) "n@node@_bnd.tdr")
