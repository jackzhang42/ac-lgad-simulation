# inspect

set N @node@
proj_load "transient_lgad_LGAD_n@node|-1@_des.plt" T($N)

set begin 1e-10
# set begin 0.0e-10
set end 5e-9

gr_setTitleAttr Transient
cv_createDS t_1($N) "T($N) time" "T($N) pad_1 TotalCurrent" y
cv_createDS t_2($N) "T($N) time" "T($N) pad_2 TotalCurrent" y
cv_createDS t_3($N) "T($N) time" "T($N) pad_3 TotalCurrent" y

cv_create t_0($N) "T($N) time" "T($N) Cathode TotalCurrent" y

cv_setCurveAttr t_1($N) "strip_1" green solid 2 none 3 defcolor 1 defcolor
cv_setCurveAttr t_2($N) "strip_2" yellow solid 2 none 3 defcolor 1 defcolor
cv_setCurveAttr t_3($N) "strip_3" blue solid 2 none 3 defcolor 1 defcolor
gr_setAxisAttr X {time(s)} 18 {} {} black 1 12 0 5 0
gr_setAxisAttr Y {strip current(A)} 18 {} {} black 1 12 0 5 0

# set charge_1 [cv_integrate t_1($N) 0 $end]
# set charge_2 [cv_integrate t_2($N) 0 $end]
# set charge_3 [cv_integrate t_3($N) 0 $end]

set charge_1 [cv_compute "vecvaly(integr(<t_1($N)>), $end) - vecvaly(integr(<t_1($N)>), $begin)" A A A A]
set charge_2 [cv_compute "vecvaly(integr(<t_2($N)>), $end) - vecvaly(integr(<t_2($N)>), $begin)" A A A A]
set charge_3 [cv_compute "vecvaly(integr(<t_3($N)>), $end) - vecvaly(integr(<t_3($N)>), $begin)" A A A A]

set charge_0 [cv_compute "vecvaly(integr(<t_0($N)>), $end) - vecvaly(integr(<t_0($N)>), $begin)" A A A A]

set peak_time_1 [cv_compute "vecvalx(<t_1($N)>, vecmax(<t_1($N)>))" A A A A]
set peak_time_2 [cv_compute "vecvalx(<t_2($N)>, vecmax(<t_2($N)>))" A A A A]
set peak_time_3 [cv_compute "vecvalx(<t_3($N)>, vecmax(<t_3($N)>))" A A A A]

set peak_current_1 [cv_compute "vecmax(<t_1($N)>)" A A A A]
set peak_current_2 [cv_compute "vecmax(<t_2($N)>)" A A A A]
set peak_current_3 [cv_compute "vecmax(<t_3($N)>)" A A A A]

set charge [expr - $charge_0]

ft_scalar peak_time_1 $peak_time_1
ft_scalar peak_time_2 $peak_time_2
ft_scalar peak_time_3 $peak_time_3

ft_scalar peak_current_1 $peak_current_1
ft_scalar peak_current_2 $peak_current_2
ft_scalar peak_current_3 $peak_current_3

ft_scalar charge $charge
