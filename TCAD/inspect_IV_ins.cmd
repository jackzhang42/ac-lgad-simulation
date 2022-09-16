# inspect

set N @node@

proj_load "IV_lgad_LGAD_n@node|-2@_des.plt" D($N)

gr_setTitleAttr IV

cv_createDS IV($N) "D($N) Cathode InnerVoltage" "D($N) Cathode TotalCurrent" y

cv_setCurveAttr IV($N) "IV($N)" blue solid 2 none 3 defcolor 1 defcolor

gr_setAxisAttr X {cathode voltage(V)} 18 {} {} black 1 12 0 5 0
gr_setAxisAttr Y {cathode current(A/um)} 18 {} {} black 1 12 0 5 1
