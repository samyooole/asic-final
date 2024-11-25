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
#floorPlan -site coreSite -d 200 200 5 5 5 5
floorPlan -site coreSite -r 1 0.8 10 10 10 10

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
#create_clock -name clk  -period 500 -waveform {0 250} [get_ports clk]
report_clocks
setOptMode -usefulSkew false -allEndPoints true -fixHoldAllowSetupTnsDegrade false -fixDrc true -fixFanoutLoad true -fixSISlew true -checkRoutingCongestion true


#*****************************************************************************
#	Pin Assignment
#*****************************************************************************
#odd metals routing is vertical. even metals routing is horizontal
#placement of pins

getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixedPin 1 -fixOverlap 1 -spreadDirection clockwise -edge 0 -layer 2 -offsetEnd 15 -offsetStart 15 -spreadType side -pin {clk rst {inp_a[15]} {inp_a[14]} {inp_a[13]} {inp_a[12]} {inp_a[11]} {inp_a[10]} {inp_a[9]} {inp_a[8]} {inp_a[7]} {inp_a[6]} {inp_a[5]} {inp_a[4]} {inp_a[3]} {inp_a[2]} {inp_a[1]} {inp_a[0]} {inp_b[15]} {inp_b[14]} {inp_b[13]} {inp_b[12]} {inp_b[11]} {inp_b[10]} {inp_b[9]} {inp_b[8]} {inp_b[7]} {inp_b[6]} {inp_b[5]} {inp_b[4]} {inp_b[3]} {inp_b[2]} {inp_b[1]} {inp_b[0]} } -snap TRACK 


setPinAssignMode -pinEditInBatch false 

getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixedPin 1 -fixOverlap 1 -spreadDirection clockwise -edge 2 -layer 2 -offsetEnd 15 -offsetStart 15 -spreadType side -pin {{prod[31]} {prod[30]} {prod[29]} {prod[28]} {prod[27]} {prod[26]} {prod[25]} {prod[24]} {prod[23]} {prod[22]} {prod[21]} {prod[20]} {prod[19]} {prod[18]} {prod[17]} {prod[16]} {prod[15]} {prod[14]} {prod[13]} {prod[12]} {prod[11]} {prod[10]} {prod[9]} {prod[8]} {prod[7]} {prod[6]} {prod[5]} {prod[4]} {prod[3]} {prod[2]} {prod[1]} {prod[0]} } -snap TRACK 
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
clearDrc
verify_drc
verifyGeometry  -error 1000000 -warning 50
verifyConnectivity -type all -noAntenna -error 1000000 -warning 50


#Save final Design
saveNetlist $top_level.apr.v
saveNetlist $top_level.apr_pg.v -includePowerGround -excludeLeafCell
saveDesign $top_level.final.enc
extractRC -outfile $top_level.cap
rcOut -spef $top_level.spef 

##StreamOutGds

streamOut $top_level.gds -mapFile /classes/ece5746/asap7pdk/asap7PDK_e1p5/cdslib/asap7_TechLib_08/asap7_fromAPR_08b.layermap -libName $top_level -units 4000 -mode ALL


