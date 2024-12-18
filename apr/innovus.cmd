#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Mon Nov 25 18:37:17 2024                
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
win
save_global Default.globals
set init_gnd_net vss
set init_lef_file {asap7_tech_4x_170803.lef asap7sc7p5t_24_R_4x_170912.lef}
set init_verilog ../synthesis/dist_sort.ALL.1080.syn.v
set init_mmmc_file Default.view
set init_pwr_net vdd
init_design
set init_gnd_net vss
set init_lef_file {asap7_tech_4x_170803.lef asap7sc7p5t_24_R_4x_170912.lef}
set init_verilog ../synthesis/dist_sort.ALL.1080.syn.v
set init_mmmc_file Default.view
set init_pwr_net vdd
init_design
set init_gnd_net vss
set init_lef_file {asap7_tech_4x_170803.lef asap7sc7p5t_24_R_4x_170912.lef}
set init_verilog ../synthesis/dist_sort.ALL.1080.syn.v
set init_mmmc_file Default.view
set init_pwr_net vdd
init_design
init_design
init_design
init_design
