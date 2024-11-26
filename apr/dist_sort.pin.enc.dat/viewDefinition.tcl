if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name libset_fast\
   -timing\
    [list ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_INVBUF_RVT_TT.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_AO_RVT_TT.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_OA_RVT_TT.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_SEQ_RVT_TT.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_SIMPLE_RVT_TT.lib]
create_library_set -name libset_slow\
   -timing\
    [list ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_INVBUF_RVT_TT.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_AO_RVT_TT.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_OA_RVT_TT.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_SEQ_RVT_TT.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_24_SIMPLE_RVT_TT.lib]
create_rc_corner -name RC_corner_25\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 25\
   -qx_tech_file ${::IMEX::libVar}/mmmc/RC_corner_25/qrcTechFile_typ03_scaled4xV06
create_delay_corner -name delayCorner_slow\
   -library_set libset_slow\
   -rc_corner RC_corner_25
create_delay_corner -name delayCorner_fast\
   -library_set libset_fast\
   -rc_corner RC_corner_25
create_constraint_mode -name common\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/dist_sort.RVT.2300.syn.sdc]
create_analysis_view -name default_hold_view -constraint_mode common -delay_corner delayCorner_fast
create_analysis_view -name default_setup_view -constraint_mode common -delay_corner delayCorner_slow
set_analysis_view -setup [list default_setup_view] -hold [list default_hold_view]
catch {set_interactive_constraint_mode [list common] } 
