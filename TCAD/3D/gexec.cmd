# project name
name ac_lgad_3d
# execution graph
job 16 -d "10"  -post { extract_vars "$wdir" n16_des.out 16; waiting "$wdir" 16 des }  -o n16_des "sdevice pp16_des.cmd"
job 10 -d "8" -pre { snmesh_prologue $wdir 10 pp10_msh.cmd n8_msh.tdr n8_bnd.tdr } -post { extract_vars "$wdir" n10_msh.out 10; waiting "$wdir" 10 msh }  -o n10_msh "snmesh  "
job 8 -d "9" -pre { snmesh_prologue $wdir 8 pp8_msh.cmd n9_msh.tdr n9_bnd.tdr } -post { extract_vars "$wdir" n8_msh.out 8; waiting "$wdir" 8 msh }  -o n8_msh "snmesh  "
job 20 -d "19" -pre { snmesh_prologue $wdir 20 pp20_msh.cmd n19_msh.tdr n19_bnd.tdr } -post { extract_vars "$wdir" n20_msh.out 20; waiting "$wdir" 20 msh }  -o n20_msh "snmesh  "
job 7 -d "10"  -post { extract_vars "$wdir" n7_des.out 7; waiting "$wdir" 7 des }  -o n7_des "sdevice pp7_des.cmd"
job 21 -d "20" -pre { snmesh_prologue $wdir 21 pp21_msh.cmd n20_msh.tdr n20_bnd.tdr } -post { extract_vars "$wdir" n21_msh.out 21; waiting "$wdir" 21 msh }  -o n21_msh "snmesh  "
job 24 -d "21"  -post { extract_vars "$wdir" n24_des.out 24; waiting "$wdir" 24 des }  -o n24_des "sdevice pp24_des.cmd"
job 25 -d "21"  -post { extract_vars "$wdir" n25_des.out 25; waiting "$wdir" 25 des }  -o n25_des "sdevice pp25_des.cmd"
job 27   -post { extract_vars "$wdir" n27_dvs.out 27; waiting "$wdir" 27 dvs }  -o n27_dvs "sde -e -l n27_dvs.cmd"
job 9   -post { extract_vars "$wdir" n9_dvs.out 9; waiting "$wdir" 9 dvs }  -o n9_dvs "sde -e -l n9_dvs.cmd"
job 26   -post { extract_vars "$wdir" n26_dvs.out 26; waiting "$wdir" 26 dvs }  -o n26_dvs "sde -e -l n26_dvs.cmd"
job 19   -post { extract_vars "$wdir" n19_dvs.out 19; waiting "$wdir" 19 dvs }  -o n19_dvs "sde -e -l n19_dvs.cmd"
job 18   -post {  extract_vars "$wdir" n18_fps.out 18; catch {os_cp "$wdir/n18_mdr.cmd" "$wdir/n18_msh.cmd"}; catch {os_cp "$wdir/n18_mdr.bnd" "$wdir/n18_msh.bnd"}; waiting "$wdir" 18 fps }  -o n18_fps "sprocess -u n18_fps.cmd"
job 11 -d "10" -pre { snmesh_prologue $wdir 11 pp11_msh.cmd n10_msh.tdr n10_bnd.tdr } -post { extract_vars "$wdir" n11_msh.out 11; waiting "$wdir" 11 msh }  -o n11_msh "snmesh  "
job 5   -post {  extract_vars "$wdir" n5_fps.out 5; catch {os_cp "$wdir/n5_mdr.cmd" "$wdir/n5_msh.cmd"}; catch {os_cp "$wdir/n5_mdr.bnd" "$wdir/n5_msh.bnd"}; waiting "$wdir" 5 fps }  -o n5_fps "sprocess -u n5_fps.cmd"
job 6   -post { extract_vars "$wdir" n6_dvs.out 6; waiting "$wdir" 6 dvs }  -o n6_dvs "sde sde n5_fps -e -l n6_dvs.cmd"
check sprocess_fps.cmd 1645408637
check sde_for_idealize_dvs.cmd 1645415110
check sde_dvs.cmd 1636028618
check snmesh_msh.cmd 1648464155
check snmesh1_msh.cmd 1648522136
check sdevice_des.cmd 1648631664
check sdevice.par 1636780558
check global_tooldb 1470076524
check gtree.dat 1645410510
check Silicon.par 1636780505
check sde1_dvs.cmd 1635942478
check translation1_msh.cmd 1635647946
check rotate1_msh.cmd 1635821349
# included files
file sdevice.par included Silicon.par
