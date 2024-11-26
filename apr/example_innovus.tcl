setLibraryUnit -time 1ps

#*****************************************************************************
#	Initialization / Loading of Synthesized verilog Netlist
#*****************************************************************************


source ./Default.globals
init_design

### EDIT THIS TO YOUR TOPLEVEL NAME 

set top_level dist_sort

#*****************************************************************************
#	Floorplan
#*****************************************************************************

# this is example tcl to make a flexible floorplan size

#set cellheight [expr 0.270 * 4 ]
#set cellhgrid  0.216

#set fpxdim [expr $cellhgrid * 400 ]
#set fpydim [expr $cellheight * 74 ]

#floorPlan -site coreSite -s $fpxdim $fpydim 0 0 0 0
#You might want to change floorplan according to your design
floorPlan -site coreSite -d 200 200 5 5 5 5
#floorPlan -site coreSite -r 1 0.80 20 20 20 20


##Layout issues in DFF cells of x2 drive strenght causes drc errors. 
setDontUse asap7sc7p5t_22b_SEQ_RVT_TT_170906/*x2_ASAP7_75t_R true
setDontUse asap7sc7p5t_22b_INVBUF_RVT_TT_170906/BUFx16f_ASAP7_75t_R true
#*****************************************************************************
#	Global Net Connection
#*****************************************************************************

add_tracks -honor_pitch 

clearGlobalNets
#global net names are case sensitive.

#globalNetConnect VDD -type pgpin -pin vdd -inst * -module {}
#globalNetConnect VSS -type pgpin -pin vss -inst * -module {}
globalNetConnect vdd -type pgpin -pin VDD -inst * -module {}
globalNetConnect vss -type pgpin -pin VSS -inst * -module {}


#*****************************************************************************
#	Tap cells and blockages
#*****************************************************************************

addWellTap -cell TAPCELL_ASAP7_75t_R -cellInterval 50 -inRowOffset 10.564 -prefix WELLTAP

saveDesign $top_level.pre_power.enc


#*****************************************************************************
#	Power Planning 
#*****************************************************************************


#Note: You can add power rings: Commands to put power rings are given below in comments.

#odd metals routing is vertical. even metals routing is horizontal

##Power rings
addRing -nets {vdd vss } -around default_power_domain -center 1 -width 1.224 -spacing 0.5 -layer {left M1 right M1 bottom M2 top M2} -extend_corner {lb lt rb rt bl tl br tr} -snap_wire_center_to_grid grid
#saveDesign $top_level.power.enc

#Sprecial routing using M1
sroute -connect { blockPin padPin padRing corePin floatingStripe } -nets {vdd vss } -layerChangeRange { M1 M3 } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1 Pad } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1 Pad }
saveDesign $top_level.specialRoute.enc


setViaGenMode -viarule_preference { M6_M5widePWR1p152 M5_M4widePWR0p864 M4_M3widePWR0p864 }


setViaGenMode -bar_cut_orientation vertical

saveDesign $top_level.power_complete.enc


timeDesign -prePlace

createBasicPathGroups

setMaxRouteLayer 3
set_interactive_constraint_modes common
# HEREEEEEEEEEEEEE
#create_clock -name clk  -period 500 -waveform {0 250} [get_ports clk]
report_clocks
setOptMode -usefulSkew false -allEndPoints true -fixHoldAllowSetupTnsDegrade false -fixDrc true -fixFanoutLoad true -fixSISlew true -checkRoutingCongestion true



#*****************************************************************************
#   Pin Assignment
#*****************************************************************************
#odd metals routing is vertical. even metals routing is horizontal
#placement of pins

getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixedPin 1 -fixOverlap 1 -spreadDirection clockwise -edge 0 -layer 2 -offsetEnd 15 -offsetStart 15 -spreadType side -pin {clk rst {query[63]} {query[62]} {query[61]} {query[60]} {query[59]} {query[58]} {query[57]} {query[56]} {query[55]} {query[54]} {query[53]} {query[52]} {query[51]} {query[50]} {query[49]} {query[48]} {query[47]} {query[46]} {query[45]} {query[44]} {query[43]} {query[42]} {query[41]} {query[40]} {query[39]} {query[38]} {query[37]} {query[36]} {query[35]} {query[34]} {query[33]} {query[32]} {query[31]} {query[30]} {query[29]} {query[28]} {query[27]} {query[26]} {query[25]} {query[24]} {query[23]} {query[22]} {query[21]} {query[20]} {query[19]} {query[18]} {query[17]} {query[16]} {query[15]} {query[14]} {query[13]} {query[12]} {query[11]} {query[10]} {query[9]} {query[8]} {query[7]} {query[6]} {query[5]} {query[4]} {query[3]} {query[2]} {query[1]} {query[0]} {search_0[63]} {search_0[62]} {search_0[61]} {search_0[60]} {search_0[59]} {search_0[58]} {search_0[57]} {search_0[56]} {search_0[55]} {search_0[54]} {search_0[53]} {search_0[52]} {search_0[51]} {search_0[50]} {search_0[49]} {search_0[48]} {search_0[47]} {search_0[46]} {search_0[45]} {search_0[44]} {search_0[43]} {search_0[42]} {search_0[41]} {search_0[40]} {search_0[39]} {search_0[38]} {search_0[37]} {search_0[36]} {search_0[35]} {search_0[34]} {search_0[33]} {search_0[32]} {search_0[31]} {search_0[30]} {search_0[29]} {search_0[28]} {search_0[27]} {search_0[26]} {search_0[25]} {search_0[24]} {search_0[23]} {search_0[22]} {search_0[21]} {search_0[20]} {search_0[19]} {search_0[18]} {search_0[17]} {search_0[16]} {search_0[15]} {search_0[14]} {search_0[13]} {search_0[12]} {search_0[11]} {search_0[10]} {search_0[9]} {search_0[8]} {search_0[7]} {search_0[6]} {search_0[5]} {search_0[4]} {search_0[3]} {search_0[2]} {search_0[1]} {search_0[0]} {search_1[63]} {search_1[62]} {search_1[61]} {search_1[60]} {search_1[59]} {search_1[58]} {search_1[57]} {search_1[56]} {search_1[55]} {search_1[54]} {search_1[53]} {search_1[52]} {search_1[51]} {search_1[50]} {search_1[49]} {search_1[48]} {search_1[47]} {search_1[46]} {search_1[45]} {search_1[44]} {search_1[43]} {search_1[42]} {search_1[41]} {search_1[40]} {search_1[39]} {search_1[38]} {search_1[37]} {search_1[36]} {search_1[35]} {search_1[34]} {search_1[33]} {search_1[32]} {search_1[31]} {search_1[30]} {search_1[29]} {search_1[28]} {search_1[27]} {search_1[26]} {search_1[25]} {search_1[24]} {search_1[23]} {search_1[22]} {search_1[21]} {search_1[20]} {search_1[19]} {search_1[18]} {search_1[17]} {search_1[16]} {search_1[15]} {search_1[14]} {search_1[13]} {search_1[12]} {search_1[11]} {search_1[10]} {search_1[9]} {search_1[8]} {search_1[7]} {search_1[6]} {search_1[5]} {search_1[4]} {search_1[3]} {search_1[2]} {search_1[1]} {search_1[0]} {search_2[63]} {search_2[62]} {search_2[61]} {search_2[60]} {search_2[59]} {search_2[58]} {search_2[57]} {search_2[56]} {search_2[55]} {search_2[54]} {search_2[53]} {search_2[52]} {search_2[51]} {search_2[50]} {search_2[49]} {search_2[48]} {search_2[47]} {search_2[46]} {search_2[45]} {search_2[44]} {search_2[43]} {search_2[42]} {search_2[41]} {search_2[40]} {search_2[39]} {search_2[38]} {search_2[37]} {search_2[36]} {search_2[35]} {search_2[34]} {search_2[33]} {search_2[32]} {search_2[31]} {search_2[30]} {search_2[29]} {search_2[28]} {search_2[27]} {search_2[26]} {search_2[25]} {search_2[24]} {search_2[23]} {search_2[22]} {search_2[21]} {search_2[20]} {search_2[19]} {search_2[18]} {search_2[17]} {search_2[16]} {search_2[15]} {search_2[14]} {search_2[13]} {search_2[12]} {search_2[11]} {search_2[10]} {search_2[9]} {search_2[8]} {search_2[7]} {search_2[6]} {search_2[5]} {search_2[4]} {search_2[3]} {search_2[2]} {search_2[1]} {search_2[0]} {search_3[63]} {search_3[62]} {search_3[61]} {search_3[60]} {search_3[59]} {search_3[58]} {search_3[57]} {search_3[56]} {search_3[55]} {search_3[54]} {search_3[53]} {search_3[52]} {search_3[51]} {search_3[50]} {search_3[49]} {search_3[48]} {search_3[47]} {search_3[46]} {search_3[45]} {search_3[44]} {search_3[43]} {search_3[42]} {search_3[41]} {search_3[40]} {search_3[39]} {search_3[38]} {search_3[37]} {search_3[36]} {search_3[35]} {search_3[34]} {search_3[33]} {search_3[32]} {search_3[31]} {search_3[30]} {search_3[29]} {search_3[28]} {search_3[27]} {search_3[26]} {search_3[25]} {search_3[24]} {search_3[23]} {search_3[22]} {search_3[21]} {search_3[20]} {search_3[19]} {search_3[18]} {search_3[17]} {search_3[16]} {search_3[15]} {search_3[14]} {search_3[13]} {search_3[12]} {search_3[11]} {search_3[10]} {search_3[9]} {search_3[8]} {search_3[7]} {search_3[6]} {search_3[5]} {search_3[4]} {search_3[3]} {search_3[2]} {search_3[1]} {search_3[0]} {search_4[63]} {search_4[62]} {search_4[61]} {search_4[60]} {search_4[59]} {search_4[58]} {search_4[57]} {search_4[56]} {search_4[55]} {search_4[54]} {search_4[53]} {search_4[52]} {search_4[51]} {search_4[50]} {search_4[49]} {search_4[48]} {search_4[47]} {search_4[46]} {search_4[45]} {search_4[44]} {search_4[43]} {search_4[42]} {search_4[41]} {search_4[40]} {search_4[39]} {search_4[38]} {search_4[37]} {search_4[36]} {search_4[35]} {search_4[34]} {search_4[33]} {search_4[32]} {search_4[31]} {search_4[30]} {search_4[29]} {search_4[28]} {search_4[27]} {search_4[26]} {search_4[25]} {search_4[24]} {search_4[23]} {search_4[22]} {search_4[21]} {search_4[20]} {search_4[19]} {search_4[18]} {search_4[17]} {search_4[16]} {search_4[15]} {search_4[14]} {search_4[13]} {search_4[12]} {search_4[11]} {search_4[10]} {search_4[9]} {search_4[8]} {search_4[7]} {search_4[6]} {search_4[5]} {search_4[4]} {search_4[3]} {search_4[2]} {search_4[1]} {search_4[0]} {search_5[63]} {search_5[62]} {search_5[61]} {search_5[60]} {search_5[59]} {search_5[58]} {search_5[57]} {search_5[56]} {search_5[55]} {search_5[54]} {search_5[53]} {search_5[52]} {search_5[51]} {search_5[50]} {search_5[49]} {search_5[48]} {search_5[47]} {search_5[46]} {search_5[45]} {search_5[44]} {search_5[43]} {search_5[42]} {search_5[41]} {search_5[40]} {search_5[39]} {search_5[38]} {search_5[37]} {search_5[36]} {search_5[35]} {search_5[34]} {search_5[33]} {search_5[32]} {search_5[31]} {search_5[30]} {search_5[29]} {search_5[28]} {search_5[27]} {search_5[26]} {search_5[25]} {search_5[24]} {search_5[23]} {search_5[22]} {search_5[21]} {search_5[20]} {search_5[19]} {search_5[18]} {search_5[17]} {search_5[16]} {search_5[15]} {search_5[14]} {search_5[13]} {search_5[12]} {search_5[11]} {search_5[10]} {search_5[9]} {search_5[8]} {search_5[7]} {search_5[6]} {search_5[5]} {search_5[4]} {search_5[3]} {search_5[2]} {search_5[1]} {search_5[0]} {search_6[63]} {search_6[62]} {search_6[61]} {search_6[60]} {search_6[59]} {search_6[58]} {search_6[57]} {search_6[56]} {search_6[55]} {search_6[54]} {search_6[53]} {search_6[52]} {search_6[51]} {search_6[50]} {search_6[49]} {search_6[48]} {search_6[47]} {search_6[46]} {search_6[45]} {search_6[44]} {search_6[43]} {search_6[42]} {search_6[41]} {search_6[40]} {search_6[39]} {search_6[38]} {search_6[37]} {search_6[36]} {search_6[35]} {search_6[34]} {search_6[33]} {search_6[32]} {search_6[31]} {search_6[30]} {search_6[29]} {search_6[28]} {search_6[27]} {search_6[26]} {search_6[25]} {search_6[24]} {search_6[23]} {search_6[22]} {search_6[21]} {search_6[20]} {search_6[19]} {search_6[18]} {search_6[17]} {search_6[16]} {search_6[15]} {search_6[14]} {search_6[13]} {search_6[12]} {search_6[11]} {search_6[10]} {search_6[9]} {search_6[8]} {search_6[7]} {search_6[6]} {search_6[5]} {search_6[4]} {search_6[3]} {search_6[2]} {search_6[1]} {search_6[0]} {search_7[63]} {search_7[62]} {search_7[61]} {search_7[60]} {search_7[59]} {search_7[58]} {search_7[57]} {search_7[56]} {search_7[55]} {search_7[54]} {search_7[53]} {search_7[52]} {search_7[51]} {search_7[50]} {search_7[49]} {search_7[48]} {search_7[47]} {search_7[46]} {search_7[45]} {search_7[44]} {search_7[43]} {search_7[42]} {search_7[41]} {search_7[40]} {search_7[39]} {search_7[38]} {search_7[37]} {search_7[36]} {search_7[35]} {search_7[34]} {search_7[33]} {search_7[32]} {search_7[31]} {search_7[30]} {search_7[29]} {search_7[28]} {search_7[27]} {search_7[26]} {search_7[25]} {search_7[24]} {search_7[23]} {search_7[22]} {search_7[21]} {search_7[20]} {search_7[19]} {search_7[18]} {search_7[17]} {search_7[16]} {search_7[15]} {search_7[14]} {search_7[13]} {search_7[12]} {search_7[11]} {search_7[10]} {search_7[9]} {search_7[8]} {search_7[7]} {search_7[6]} {search_7[5]} {search_7[4]} {search_7[3]} {search_7[2]} {search_7[1]} {search_7[0]} in_valid } -snap TRACK 
setPinAssignMode -pinEditInBatch false 

getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixedPin 1 -fixOverlap 1 -spreadDirection clockwise -edge 2 -layer 2 -offsetEnd 15 -offsetStart 15 -spreadType side -pin { addr_1st[2] addr_1st[1] addr_1st[0] addr_2nd[2] addr_2nd[1] addr_2nd[0] out_valid } -snap TRACK 
setPinAssignMode -pinEditInBatch false 


saveDesign $top_level.pin.enc


#*****************************************************************************
#	Placement of Standard Cells
#*****************************************************************************


# placement pre-clock cts goes here... place your standard cells
#### Place Design
setPlaceMode -place_global_timing_effort high
setPlaceMode -place_global_reorder_scan false
setPlaceMode -place_global_cong_effort high
place_opt_design

#setOptMode -fixdrc true
#optDesign -preCTS
#optDesign -preCTS -drv
#optDesign -preCTS -incr
#*****************************************************************************
#	CTS (Clock Tree Synthesis)
#*****************************************************************************

# CTS

setNanoRouteMode -drouteMinimizeLithoEffectOnLayer {f t t t t t t t t t} \
    -routeTopRoutingLayer 3 -routeBottomRoutingLayer 2 \
    -routeWithViaInPin true -routeWithTimingDriven true

# set desired clock cells here...
#set_ccopt_property buffer_cells {BUFx10_ASAP7_75t_R BUFx12_ASAP7_75t_R BUFx12f_ASAP7_75t_R BUFx16f_ASAP7_75t_R BUFx24_ASAP7_75t_R BUFx2_ASAP7_75t_R BUFx3_ASAP7_75t_R BUFx4_ASAP7_75t_R BUFx5_ASAP7_75t_R BUFx4f_ASAP7_75t_R BUFx6f_ASAP7_75t_R BUFx8_ASAP7_75t_R HB1xp67_ASAP7_75t_R HB2xp67_ASAP7_75t_R}

set_ccopt_property inverter_cells {INVx11_ASAP7_75t_R INVx13_ASAP7_75t_R INVx1_ASAP7_75t_R INVx2_ASAP7_75t_R INVx3_ASAP7_75t_R INVx4_ASAP7_75t_R INVx5_ASAP7_75t_R INVx6_ASAP7_75t_R INVx8_ASAP7_75t_R INVxp67_ASAP7_75t_R INVxp33_ASAP7_75t_R}

#set_ccopt_property target_skew 5ps 
#set_ccopt_property target_max_trans 30ps
#setNanoRouteMode -routeTopRoutingLayer 5 -routeBottomRoutingLayer 2
#create_route_type -name ccopt_route_group -bottom_preferred_layer 4 -top_preferred_layer 5
#create_ccopt_clock_tree_spec
#ccopt_design -cts

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
set_ccopt_property target_max_trans  100ps


# Create CTS specification
create_ccopt_clock_tree_spec -filename ./cts/ccopt.spec
source ./cts/ccopt.spec
    
# Run CCopt
clock_opt_design -outDir ./cts/
    
# Report timing

    
# Report clock trees to check area and other statistics



#*****************************************************************************
#	Post-CTS optimization
#*****************************************************************************

#Post CTS

optDesign -postCTS -incr
optDesign -postCTS -hold
optDesign -postCTS -drv
report_ccopt_clock_trees -filename ./cts/clock_trees.rpt
report_ccopt_skew_groups -filename ./cts/skew_groups.rpt
timeDesign -postCTS -expandedViews -outDir ./cts/timing/
saveDesign $top_level.clock.enc


#*****************************************************************************
#	Route
#*****************************************************************************

#Nano routing
setNanoRouteMode -drouteMinimizeLithoEffectOnLayer {t t t t t t t t t t} 
setNanoRouteMode -routeWithViaInPin true -routeDesignFixClockNets true -routeTopRoutingLayer 3
setNanoRouteMode -quiet -drouteFixAntenna 0
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven false
setNanoRouteMode -drouteEndIteration 20
routeDesign 

saveDesign $top_level.route.enc

setAnalysisMode -analysisType onChipVariation -cppr both

optDesign -postRoute -incr
optDesign -postRoute -setup
optDesign -postRoute -hold 



timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 500 -outDir timingReports/
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 500 -outDir timingReports/

#*****************************************************************************
#	Add Filler
#*****************************************************************************


# all done--finish up with decap and finally filler

addFiller -cell {FILLER_ASAP7_75t_R FILLERxp5_ASAP7_75t_R } -prefix FILLER_

#*****************************************************************************
#	Verify Geometry & Connectivity
#*****************************************************************************

# connectivity
#verifyConnectivity

# to also generate report
verifyConnectivity -report "./dist_sort.conn.rpt"
verify_drc -report "./dist_sort.geom.rpt"


#Save final Design
saveNetlist $top_level.apr.v
saveNetlist $top_level.apr_pg.v -includePowerGround -excludeLeafCell
saveDesign $top_level.final.enc
extractRC -outfile $top_level.cap
rcOut -spef $top_level.spef 

##StreamOutGds

streamOut $top_level.gds -mapFile /classes/ece5746/asap7pdk/asap7PDK_e1p5/cdslib/asap7_TechLib_08/asap7_fromAPR_08b.layermap -libName $top_level -units 4000 -mode ALL


