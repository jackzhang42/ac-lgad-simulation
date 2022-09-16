# define variables
set xlow 0.0
set xhigh 50.0
set ylow 0.0
set yhigh 1300.0

set npad 5
set gap 75.0
set side 100.0

set ljte 25.0
set metalext 15.0
set tnpp 1.0
set tnp 1.0
set tp 1.0
set tox 1.0
set tdiel 0.1
set tmetal 1.0
set tppp 1.0
set tjte [expr $tp + $tnpp]
set pstopwidth 20
set pstoptojte 30
set grwidth 60
set pstoptogr 30
set grext 16
set lnp [expr ($npad + 1) * $gap + $npad * $side + 2 * $tmetal]

set npleft [expr ($yhigh - $lnp)/2]
set npright [expr $yhigh - $npleft]
set jte1left [expr $npleft - $ljte / 2]
set jte1right [expr $npleft + $ljte / 2]
set jte2left [expr $npright - $ljte / 2]
set jte2right [expr $npright + $ljte / 2]
set metalleft [expr $npleft - $metalext]
set metalright [expr $npright + $metalext]

set pstop1right [expr $jte1left - $pstoptojte]
set pstop1left [expr $pstop1right - $pstopwidth]
set pstop2left [expr $jte2right + $pstoptojte]
set pstop2right [expr $pstop2left + $pstopwidth]

set gr1right [expr $pstop1left - $pstoptogr]
set gr1left [expr $gr1right - $grwidth]
set gr2left [expr $pstop2right + $pstoptogr]
set gr2right [expr $gr2left + $grwidth]

set gr1leftext [expr $gr1left - $grext]
set gr1rightext [expr $gr1right + $grext]
set gr2leftext [expr $gr2left - $grext]
set gr2rightext [expr $gr2right + $grext]

set acleft [expr $npleft + $tmetal]
set acright [expr $npright - $tmetal]
set acleftshifted [expr $acleft + 0.001]
set acrightshifted [expr $acright - 0.001]

set npp1left [expr $npleft - 1]
set npp1right [expr $acleft + 1]
set npp2left [expr $acright - 1]
set npp2right [expr $npright + 1]

set pad1left [expr $acleft + $gap]
set pad1right [expr $pad1left + $side]
set pad2left [expr $pad1right + $gap]
set pad2right [expr $pad2left + $side]
set pad3left [expr $pad2right + $gap]
set pad3right [expr $pad3left + $side]
set pad4left [expr $pad3right + $gap]
set pad4right [expr $pad4left + $side]
set pad5left [expr $pad4right + $gap]
set pad5right [expr $pad5left + $side]

# set hitpos [expr 650.0 + @position@ * 35.0]
# set hitposleft [expr $hitpos - 0.5]
# set hitposright [expr $hitpos + 0.5]

set subconc 5e12
set nppconc 4.5e15
set npconc @npconc@
set pconc @pconc@
set pppconc 1e13
set jteconc @npconc@
set pstopconc 4.5e15
set grconc 4.5e15

set nppenergy 60
set npenergy 60
set penergy 1000
set jteenergy 60

set difftime 60
set difftemp 1200
set annltime 10
set annltemp 1200

set pppenergy 60
set grenergy 60
set pstopenergy 100

set tilt 7

# define grid
line x loc=$xlow spacing=1 tag=sublow
line x loc=$xhigh spacing=1 tag=subhigh
line y loc=$ylow spacing=5 tag=subleft
line y loc=$yhigh spacing=5 tag=subright

# remeshing strategy
grid set.min.normal.size=50<nm> set.normal.growth.ratio.2d=1.2

region Silicon xlo=sublow xhi=subhigh ylo=subleft yhi=subright
init field=Boron concentration=$subconc

# define mask
mask name=np_p segments= {$npleft $npright}
mask name=np_n segments= {$npleft $npright} negative
mask name=metaldepo segments= {$metalleft $metalright} negative
mask name=jte segments= {$jte1left $jte1right $jte2left $jte2right}
mask name=npp segments= {$npp1left $npp1right $npp2left $npp2right}
mask name=pad segments= {$pad1left $pad1right $pad2left $pad2right $pad3left $pad3right $pad4left $pad4right $pad5left $pad5right} negative
mask name=acpads segments= {$acleft $acright} negative
mask name=acpads_another segments= {$acleftshifted $acrightshifted} negative
mask name=pstop segments= {$pstop1left $pstop1right $pstop2left $pstop2right}
mask name=gr segments= {$gr1left $gr1right $gr2left $gr2right}
mask name=grplate segments= {$gr1leftext $gr1rightext $gr2leftext $gr2rightext} negative
mask name=oxide segments= {$gr1left $gr1right $npleft $npright $gr2left $gr2right}
AdvancedCalibration
math coord.ucs

# implant gr
photo mask=gr thickness=1.0
implant Phosphorus energy=$grenergy dose=$grconc tilt=$tilt
strip resist

# implant npp
photo mask=npp thickness=1.0
implant Phosphorus energy=$nppenergy dose=$nppconc tilt=$tilt
strip resist

# implant pstop
photo mask=pstop thickness=1.0
implant Boron energy=$pstopenergy dose=$pstopconc tilt=$tilt
strip resist

diffuse temp=$difftemp time=$difftime

#if @conventional@ == 0
# implant p layer
photo mask=np_p thickness=10
implant Boron energy=$penergy dose=$pconc tilt=$tilt
strip resist
#endif

# implant np layer
photo mask=np_p thickness=10
implant Phosphorus energy=$npenergy dose=$npconc tilt=$tilt
strip resist

# flip
transform flip

implant Boron energy=$pppenergy dose=$pppconc tilt=$tilt

# anneal 
diffuse temp=$annltemp time=$annltime<s>


# cancel for later idealized sde operation
# deposit cathode
# deposit material= {Aluminum} type=anisotropic time=1.0 rate= {$tmetal}

transform flip

# cancel for later sde
# deposit SiO2
# deposit material= {SiO2} type=anisotropic time=1.0 rate= {$tox} mask= oxide

# cancel for later sde
# deposit anode
# deposit material= {Aluminum} type=isotropic time=1.0 rate= {$tmetal} mask= metaldepo

# cancel for later sde
#if "@type@" == "ac"
# etch material= {Aluminum} type=anisotropic time=1.2 rate= {$tmetal} mask= acpads

# cancel for later sde
# deposit material= {Si3N4} type= anisotropic time=1.0 rate= {$tdiel} mask= acpads_another

# cancel for later sde operation
# deposit material= {Aluminum} type= anisotropic time=1.0 rate= {$tmetal} mask= pad
#endif

# cancel for later sde
# deposit plate
# deposit material= {Aluminum} type= isotropic time=1.0 rate= {$tmetal} mask= grplate

# remesh
# refinebox clear
# refinebox clear.interface.mats
# refinebox !keep.lines
# line clear

# pdbSet Grid SnMesh DelaunayType boxmethod

# refinebox Silicon refine.fields= {NetActive} max.gradient= {NetActive= 100.0} refine.min.edge= {0.4 0.4} refine.max.edge= {1 1}
# refinebox Silicon min= {0 $hitposleft} max= {50 $hitposright} xrefine=0.2 yrefine=0.02

# grid remesh

struct smesh=n@node@
exit

