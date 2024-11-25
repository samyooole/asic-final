#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon Nov 25 13:23:53 2024                
#                                                     
#######################################################

#@(#)CDS: Innovus v23.12-s091_1 (64bit) 07/30/2024 16:11 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 23.12-s091_1 NR240717-0458/23_12-UB (database version 18.20.633) {superthreading v2.20}
#@(#)CDS: AAE 23.12-s024 (64bit) 07/30/2024 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 23.12-s018_1 () Jul 26 2024 06:03:48 ( )
#@(#)CDS: SYNTECH 23.12-s010_1 () Jul 16 2024 00:01:03 ( )
#@(#)CDS: CPE v23.12-s039
#@(#)CDS: IQuantus/TQuantus 23.1.1-s122 (64bit) Tue May 28 20:12:45 PDT 2024 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
define_proc_arguments ViaFillQor -info {This procedure extracts Viafill details from innovus db} -define_args {
        {-window "window coordinates" "" list optional}
        {-window_size "window size in microns" "" string optional}
    
    }
define_proc_arguments ProcessFills -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor_fast -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast_stampOnly -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
	
}
define_proc_arguments FillQor_fast_stampOnly -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
}
setLibraryUnit -time 1ps
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set distributed_client_message_echo 1
set gpsPrivate::dpgNewAddBufsDBUpdate 1
set gpsPrivate::lsgEnableNewDbApiInRestruct 1
set init_gnd_net vss
set init_lef_file {<your_local_path_to_lef>/asap7_tech_4x_170803.lef <your_local_path_to_lef>/asap7sc7p5t_24_R_4x_170912.lef}
set init_mmmc_file <your_local_path_to_Default.view>/Default.view
set init_pwr_net vdd
set init_verilog ../synthesis/edac.v
set pegDefaultResScaleFactor 1.000000
set pegDetailResScaleFactor 1.000000
set timing_library_float_precision_tol 0.000010
set timing_library_load_pin_cap_indices {}
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}
init_design
setLibraryUnit -time 1ps
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set distributed_client_message_echo 1
set gpsPrivate::dpgNewAddBufsDBUpdate 1
set gpsPrivate::lsgEnableNewDbApiInRestruct 1
set init_gnd_net vss
set init_lef_file {./asap7_tech_4x_170803.lef <your_local_path_to_lef>/asap7sc7p5t_24_R_4x_170912.lef}
set init_mmmc_file ./Default.view
set init_pwr_net vdd
set init_verilog ../synthesis/edac.v
set pegDefaultResScaleFactor 1.000000
set pegDetailResScaleFactor 1.000000
set timing_library_float_precision_tol 0.000010
set timing_library_load_pin_cap_indices {}
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}
init_design
setLibraryUnit -time 1ps
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set distributed_client_message_echo 1
set gpsPrivate::dpgNewAddBufsDBUpdate 1
set gpsPrivate::lsgEnableNewDbApiInRestruct 1
set init_gnd_net vss
set init_lef_file {./asap7_tech_4x_170803.lef <./asap7sc7p5t_24_R_4x_170912.lef}
set init_mmmc_file ./Default.view
set init_pwr_net vdd
set init_verilog ../synthesis/edac.v
set pegDefaultResScaleFactor 1.000000
set pegDetailResScaleFactor 1.000000
set timing_library_float_precision_tol 0.000010
set timing_library_load_pin_cap_indices {}
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}
init_design
setLibraryUnit -time 1ps
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set distributed_client_message_echo 1
set gpsPrivate::dpgNewAddBufsDBUpdate 1
set gpsPrivate::lsgEnableNewDbApiInRestruct 1
set init_gnd_net vss
set init_lef_file {./asap7_tech_4x_170803.lef ./asap7sc7p5t_24_R_4x_170912.lef}
set init_mmmc_file ./Default.view
set init_pwr_net vdd
set init_verilog ../synthesis/dist_sort.ALL
set pegDefaultResScaleFactor 1.000000
set pegDetailResScaleFactor 1.000000
set timing_library_float_precision_tol 0.000010
set timing_library_load_pin_cap_indices {}
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}
init_design
setLibraryUnit -time 1ps
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set distributed_client_message_echo 1
set gpsPrivate::dpgNewAddBufsDBUpdate 1
set gpsPrivate::lsgEnableNewDbApiInRestruct 1
set init_gnd_net vss
set init_lef_file {./asap7_tech_4x_170803.lef ./asap7sc7p5t_24_R_4x_170912.lef}
set init_mmmc_file ./Default.view
set init_pwr_net vdd
set init_verilog ../synthesis/dist_sort.ALL.1080.syn.v
set pegDefaultResScaleFactor 1.000000
set pegDetailResScaleFactor 1.000000
set timing_library_float_precision_tol 0.000010
set timing_library_load_pin_cap_indices {}
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}
init_design
init_design
init_design
floorPlan -site coreSite -r 1 0.6 5 5 5 5
setDontUse asap7sc7p5t_22b_SEQ_RVT_TT_170906/*x2_ASAP7_75t_R true
setDontUse asap7sc7p5t_22b_INVBUF_RVT_TT_170906/BUFx16f_ASAP7_75t_R true
add_tracks -honor_pitch
clearGlobalNets
globalNetConnect vdd -type pgpin -pin VDD -inst * -module {}
globalNetConnect vss -type pgpin -pin VSS -inst * -module {}
addWellTap -cell TAPCELL_ASAP7_75t_R -cellInterval 50 -inRowOffset 10.564 -prefix WELLTAP
saveDesign dist_sort.pre_power.enc
addRing -nets {vdd vss } -around default_power_domain -center 1 -width 1.224 -spacing 0.5 -layer {left M1 right M1 bottom M2 top M2} -extend_corner {lb lt rb rt bl tl br tr} -snap_wire_center_to_grid grid
sroute -connect { blockPin padPin padRing corePin floatingStripe } -nets {vdd vss } -layerChangeRange { M1 M3 } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1 Pad } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1 Pad }
saveDesign dist_sort.specialRoute.enc
setViaGenMode -viarule_preference { M6_M5widePWR1p152 M5_M4widePWR0p864 M4_M3widePWR0p864 }
setViaGenMode -bar_cut_orientation vertical
saveDesign dist_sort.power_complete.enc
timeDesign -prePlace
createBasicPathGroups
setRouteMode -earlyGlobalMaxRouteLayer 3
setPinAssignMode -maxLayer 3
setNanoRouteMode -routeTopRoutingLayer 3
setDesignMode -topRoutingLayer M3
set_interactive_constraint_modes common
report_clocks
setOptMode -usefulSkew false -allEndPoints true -fixHoldAllowSetupTnsDegrade false -fixDrc true -fixFanoutLoad true -fixSISlew true -checkRoutingCongestion true
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixedPin 1 -fixOverlap 1 -spreadDirection clockwise -edge 0 -layer 2 -offsetEnd 15 -offsetStart 15 -spreadType side -pin {clk rst {inp_a[15]} {inp_a[14]} {inp_a[13]} {inp_a[12]} {inp_a[11]} {inp_a[10]} {inp_a[9]} {inp_a[8]} {inp_a[7]} {inp_a[6]} {inp_a[5]} {inp_a[4]} {inp_a[3]} {inp_a[2]} {inp_a[1]} {inp_a[0]} {inp_b[15]} {inp_b[14]} {inp_b[13]} {inp_b[12]} {inp_b[11]} {inp_b[10]} {inp_b[9]} {inp_b[8]} {inp_b[7]} {inp_b[6]} {inp_b[5]} {inp_b[4]} {inp_b[3]} {inp_b[2]} {inp_b[1]} {inp_b[0]} } -snap TRACK
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixedPin 1 -fixOverlap 1 -spreadDirection clockwise -edge 2 -layer 2 -offsetEnd 15 -offsetStart 15 -spreadType side -pin {{prod[31]} {prod[30]} {prod[29]} {prod[28]} {prod[27]} {prod[26]} {prod[25]} {prod[24]} {prod[23]} {prod[22]} {prod[21]} {prod[20]} {prod[19]} {prod[18]} {prod[17]} {prod[16]} {prod[15]} {prod[14]} {prod[13]} {prod[12]} {prod[11]} {prod[10]} {prod[9]} {prod[8]} {prod[7]} {prod[6]} {prod[5]} {prod[4]} {prod[3]} {prod[2]} {prod[1]} {prod[0]} } -snap TRACK
setPinAssignMode -pinEditInBatch false
saveDesign dist_sort.pin.enc
setPlaceMode -place_global_timing_effort high
setPlaceMode -place_global_reorder_scan false
setPlaceMode -place_global_cong_effort high
place_opt_design
setNanoRouteMode -drouteMinimizeLithoEffectOnLayer {f t t t t t t t t t} -routeTopRoutingLayer 3 -routeBottomRoutingLayer 2 -routeWithViaInPin true -routeWithTimingDriven true
set_ccopt_property inverter_cells {INVx11_ASAP7_75t_R INVx13_ASAP7_75t_R INVx1_ASAP7_75t_R INVx2_ASAP7_75t_R INVx3_ASAP7_75t_R INVx4_ASAP7_75t_R INVx5_ASAP7_75t_R INVx6_ASAP7_75t_R INVx8_ASAP7_75t_R INVxp67_ASAP7_75t_R INVxp33_ASAP7_75t_R}
set_ccopt_property cts_add_wire_delay_in_detailed_balancer true
set_ccopt_property cts_compute_fastest_drivers_and_slews_for_clustering multi_corner
set_ccopt_property cts_clustering_net_skew_limit_as_proportion_of_skew_target 0.5
set_ccopt_property routing_top_min_fanout 2000
set_ccopt_property cell_density 0.5
set_ccopt_property adjacent_rows_legal false
set_ccopt_property ccopt_auto_limit_insertion_delay_factor 1.0
set_ccopt_property skew_band_size 0.1
set_ccopt_property useful_skew_use_gigaopt_for_mfn_chain_speed true
set_ccopt_property useful_skew_implement_using_wns_windows false
set_ccopt_property target_max_trans 100ps
create_ccopt_clock_tree_spec -filename ./cts/ccopt.spec
get_ccopt_clock_trees
ccopt_check_and_flatten_ilms_no_restore
set_ccopt_property cts_is_sdc_clock_root -pin clk true
set_ccopt_property timing_connectivity_info {}
check_ccopt_clock_tree_convergence
get_ccopt_property auto_design_state_for_ilms
clock_opt_design -outDir ./cts/
optDesign -postCTS -incr
optDesign -postCTS -hold
optDesign -postCTS -drv
report_ccopt_clock_trees -filename ./cts/clock_trees.rpt
report_ccopt_skew_groups -filename ./cts/skew_groups.rpt
timeDesign -postCTS -expandedViews -outDir ./cts/timing/
saveDesign dist_sort.clock.enc
setNanoRouteMode -drouteMinimizeLithoEffectOnLayer {t t t t t t t t t t}
setNanoRouteMode -routeWithViaInPin true -routeDesignFixClockNets true -routeTopRoutingLayer 3
setNanoRouteMode -quiet -drouteFixAntenna 0
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven false
setNanoRouteMode -drouteEndIteration 20
routeDesign
saveDesign dist_sort.route.enc
setAnalysisMode -analysisType onChipVariation -cppr both
optDesign -postRoute -incr
optDesign -postRoute -setup
optDesign -postRoute -hold
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 500 -outDir timingReports/
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 500 -outDir timingReports/
addFiller -cell {FILLER_ASAP7_75t_R FILLERxp5_ASAP7_75t_R } -prefix FILLER_
clearDrc
verify_drc
verifyConnectivity -type all -noAntenna -error 1000000 -warning 50
saveNetlist dist_sort.apr.v
saveNetlist dist_sort.apr_pg.v -includePowerGround -excludeLeafCell
saveDesign dist_sort.final.enc
extractRC -outfile dist_sort.cap
rcOut -spef dist_sort.spef
streamOut dist_sort.gds -mapFile /classes/ece5746/asap7pdk/asap7PDK_e1p5/cdslib/asap7_TechLib_08/asap7_fromAPR_08b.layermap -libName dist_sort -units 4000 -mode ALL
