# project name
name USTC_W6
# execution graph
job 666   -post { extract_vars "$wdir" n666_ins.out 666; waiting "$wdir" 666 ins }  -o n666_ins "inspect -f pp666_ins.cmd"
job 649 -d "648" -pre { snmesh_prologue $wdir 649 pp649_msh.cmd n648_fps.tdr n648_bnd.tdr } -post { extract_vars "$wdir" n649_msh.out 649; waiting "$wdir" 649 msh }  -o n649_msh "snmesh  "
job 665 -d "649"  -post { extract_vars "$wdir" n665_des.out 665; waiting "$wdir" 665 des }  -o n665_des "sdevice pp665_des.cmd"
job 309 -d "2"  -post { extract_vars "$wdir" n309_des.out 309; waiting "$wdir" 309 des }  -o n309_des "sdevice pp309_des.cmd"
job 312 -d "2"  -post { extract_vars "$wdir" n312_des.out 312; waiting "$wdir" 312 des }  -o n312_des "sdevice pp312_des.cmd"
job 315 -d "2"  -post { extract_vars "$wdir" n315_des.out 315; waiting "$wdir" 315 des }  -o n315_des "sdevice pp315_des.cmd"
job 648   -post {  extract_vars "$wdir" n648_fps.out 648; catch {os_cp "$wdir/n648_mdr.cmd" "$wdir/n648_msh.cmd"}; catch {os_cp "$wdir/n648_mdr.bnd" "$wdir/n648_msh.bnd"}; waiting "$wdir" 648 fps }  -o n648_fps "sprocess -u -b n648_fps.cmd"
job 311   -post { extract_vars "$wdir" n311_ins.out 311; waiting "$wdir" 311 ins }  -o n311_ins "inspect -f pp311_ins.cmd"
job 338   -post { extract_vars "$wdir" n338_ins.out 338; waiting "$wdir" 338 ins }  -o n338_ins "inspect -f pp338_ins.cmd"
job 337 -d "45"  -post { extract_vars "$wdir" n337_des.out 337; waiting "$wdir" 337 des }  -o n337_des "sdevice pp337_des.cmd"
job 320   -post { extract_vars "$wdir" n320_ins.out 320; waiting "$wdir" 320 ins }  -o n320_ins "inspect -f pp320_ins.cmd"
job 319 -d "2"  -post { extract_vars "$wdir" n319_des.out 319; waiting "$wdir" 319 des }  -o n319_des "sdevice pp319_des.cmd"
job 329   -post { extract_vars "$wdir" n329_ins.out 329; waiting "$wdir" 329 ins }  -o n329_ins "inspect -f pp329_ins.cmd"
job 327 -d "45"  -post { extract_vars "$wdir" n327_des.out 327; waiting "$wdir" 327 des }  -o n327_des "sdevice pp327_des.cmd"
job 605   -post { extract_vars "$wdir" n605_ins.out 605; waiting "$wdir" 605 ins }  -o n605_ins "inspect -f pp605_ins.cmd"
job 625   -post { extract_vars "$wdir" n625_ins.out 625; waiting "$wdir" 625 ins }  -o n625_ins "inspect -f pp625_ins.cmd"
job 603 -d "597"  -post { extract_vars "$wdir" n603_des.out 603; waiting "$wdir" 603 des }  -o n603_des "sdevice pp603_des.cmd"
job 623 -d "617"  -post { extract_vars "$wdir" n623_des.out 623; waiting "$wdir" 623 des }  -o n623_des "sdevice pp623_des.cmd"
job 596   -post {  extract_vars "$wdir" n596_fps.out 596; catch {os_cp "$wdir/n596_mdr.cmd" "$wdir/n596_msh.cmd"}; catch {os_cp "$wdir/n596_mdr.bnd" "$wdir/n596_msh.bnd"}; waiting "$wdir" 596 fps }  -o n596_fps "sprocess -u -b n596_fps.cmd"
job 597 -d "596" -pre { snmesh_prologue $wdir 597 pp597_msh.cmd n596_fps.tdr n596_bnd.tdr } -post { extract_vars "$wdir" n597_msh.out 597; waiting "$wdir" 597 msh }  -o n597_msh "snmesh  "
job 616   -post {  extract_vars "$wdir" n616_fps.out 616; catch {os_cp "$wdir/n616_mdr.cmd" "$wdir/n616_msh.cmd"}; catch {os_cp "$wdir/n616_mdr.bnd" "$wdir/n616_msh.bnd"}; waiting "$wdir" 616 fps }  -o n616_fps "sprocess -u -b n616_fps.cmd"
job 617 -d "616" -pre { snmesh_prologue $wdir 617 pp617_msh.cmd n616_fps.tdr n616_bnd.tdr } -post { extract_vars "$wdir" n617_msh.out 617; waiting "$wdir" 617 msh }  -o n617_msh "snmesh  "
job 515   -post { extract_vars "$wdir" n515_ins.out 515; waiting "$wdir" 515 ins }  -o n515_ins "inspect -f pp515_ins.cmd"
job 513 -d "507"  -post { extract_vars "$wdir" n513_des.out 513; waiting "$wdir" 513 des }  -o n513_des "sdevice pp513_des.cmd"
job 507 -d "506" -pre { snmesh_prologue $wdir 507 pp507_msh.cmd n506_fps.tdr n506_bnd.tdr } -post { extract_vars "$wdir" n507_msh.out 507; waiting "$wdir" 507 msh }  -o n507_msh "snmesh  "
job 506   -post {  extract_vars "$wdir" n506_fps.out 506; catch {os_cp "$wdir/n506_mdr.cmd" "$wdir/n506_msh.cmd"}; catch {os_cp "$wdir/n506_mdr.bnd" "$wdir/n506_msh.bnd"}; waiting "$wdir" 506 fps }  -o n506_fps "sprocess -u -b n506_fps.cmd"
job 321   -post { extract_vars "$wdir" n321_ins.out 321; waiting "$wdir" 321 ins }  -o n321_ins "inspect -f pp321_ins.cmd"
job 2 -d "1" -pre { snmesh_prologue $wdir 2 pp2_msh.cmd n1_fps.tdr n1_bnd.tdr } -post { extract_vars "$wdir" n2_msh.out 2; waiting "$wdir" 2 msh }  -o n2_msh "snmesh  "
job 45 -d "44" -pre { snmesh_prologue $wdir 45 pp45_msh.cmd n44_fps.tdr n44_bnd.tdr } -post { extract_vars "$wdir" n45_msh.out 45; waiting "$wdir" 45 msh }  -o n45_msh "snmesh  "
job 460   -post {  extract_vars "$wdir" n460_fps.out 460; catch {os_cp "$wdir/n460_mdr.cmd" "$wdir/n460_msh.cmd"}; catch {os_cp "$wdir/n460_mdr.bnd" "$wdir/n460_msh.bnd"}; waiting "$wdir" 460 fps }  -o n460_fps "sprocess -u -b n460_fps.cmd"
job 461 -d "460" -pre { snmesh_prologue $wdir 461 pp461_msh.cmd n460_fps.tdr n460_bnd.tdr } -post { extract_vars "$wdir" n461_msh.out 461; waiting "$wdir" 461 msh }  -o n461_msh "snmesh  "
job 477 -d "461"  -post { extract_vars "$wdir" n477_des.out 477; waiting "$wdir" 477 des }  -o n477_des "sdevice pp477_des.cmd"
job 62   -post { extract_vars "$wdir" n62_ins.out 62; waiting "$wdir" 62 ins }  -o n62_ins "inspect -f pp62_ins.cmd"
job 15   -post { extract_vars "$wdir" n15_ins.out 15; waiting "$wdir" 15 ins }  -o n15_ins "inspect -f pp15_ins.cmd"
job 61 -d "45"  -post { extract_vars "$wdir" n61_des.out 61; waiting "$wdir" 61 des }  -o n61_des "sdevice pp61_des.cmd"
job 44   -post {  extract_vars "$wdir" n44_fps.out 44; catch {os_cp "$wdir/n44_mdr.cmd" "$wdir/n44_msh.cmd"}; catch {os_cp "$wdir/n44_mdr.bnd" "$wdir/n44_msh.bnd"}; waiting "$wdir" 44 fps }  -o n44_fps "sprocess -u -b n44_fps.cmd"
job 40   -post { extract_vars "$wdir" n40_ins.out 40; waiting "$wdir" 40 ins }  -o n40_ins "inspect -f pp40_ins.cmd"
job 22   -post {  extract_vars "$wdir" n22_fps.out 22; catch {os_cp "$wdir/n22_mdr.cmd" "$wdir/n22_msh.cmd"}; catch {os_cp "$wdir/n22_mdr.bnd" "$wdir/n22_msh.bnd"}; waiting "$wdir" 22 fps }  -o n22_fps "sprocess -u -b n22_fps.cmd"
job 23 -d "22" -pre { snmesh_prologue $wdir 23 pp23_msh.cmd n22_fps.tdr n22_bnd.tdr } -post { extract_vars "$wdir" n23_msh.out 23; waiting "$wdir" 23 msh }  -o n23_msh "snmesh  "
job 39 -d "23"  -post { extract_vars "$wdir" n39_des.out 39; waiting "$wdir" 39 des }  -o n39_des "sdevice pp39_des.cmd"
job 5 -d "2"  -post { extract_vars "$wdir" n5_des.out 5; waiting "$wdir" 5 des }  -o n5_des "sdevice pp5_des.cmd"
job 3 -d "2"  -post { extract_vars "$wdir" n3_des.out 3; waiting "$wdir" 3 des }  -o n3_des "sdevice pp3_des.cmd"
job 9 -d "2"  -post { extract_vars "$wdir" n9_des.out 9; waiting "$wdir" 9 des }  -o n9_des "sdevice pp9_des.cmd"
job 10 -d "2"  -post { extract_vars "$wdir" n10_des.out 10; waiting "$wdir" 10 des }  -o n10_des "sdevice pp10_des.cmd"
job 8 -d "2"  -post { extract_vars "$wdir" n8_des.out 8; waiting "$wdir" 8 des }  -o n8_des "sdevice pp8_des.cmd"
job 1   -post {  extract_vars "$wdir" n1_fps.out 1; catch {os_cp "$wdir/n1_mdr.cmd" "$wdir/n1_msh.cmd"}; catch {os_cp "$wdir/n1_mdr.bnd" "$wdir/n1_msh.bnd"}; waiting "$wdir" 1 fps }  -o n1_fps "sprocess -u -b n1_fps.cmd"
check sprocess_fps.cmd 1662881400
check snmesh_msh.cmd 1662893998
check sdevice_des.cmd 1662886927
check sdevice.par 1662370712
check inspect_trans_ins.cmd 1652703377
check inspect_IV_ins.cmd 1661304847
check global_tooldb 1470076524
check gtree.dat 1662881410
check Silicon.par 1650105364
# included files
file sdevice.par included Silicon.par
