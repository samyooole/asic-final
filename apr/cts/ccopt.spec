###############################################################
#  Generated by:      Cadence Innovus 23.12-s091_1
#  OS:                Linux x86_64(Host ID ecelinux-14.ece.cornell.edu)
#  Generated on:      Mon Nov 25 13:32:33 2024
#  Design:            dist_sort
#  Command:           create_ccopt_clock_tree_spec -filename ./cts/ccopt.spec
###############################################################
#-------------------------------------------------------------------------------
# Clock tree setup script - dialect: Innovus
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

if { [get_ccopt_clock_trees] != {} } {
  error {Cannot run clock tree spec: clock trees are already defined.}
}

namespace eval ::ccopt {}
namespace eval ::ccopt::ilm {}
set ::ccopt::ilm::ccoptSpecRestoreData {}
# Start by checking for unflattened ILMs.
# Will flatten if so and then check the db sync.
if { [catch {ccopt_check_and_flatten_ilms_no_restore}] } {
  return -code error
}
# cache the value of the restore command output by the ILM flattening code
set ::ccopt::ilm::ccoptSpecRestoreData $::ccopt::ilm::ccoptRestoreILMState

# The following pins are clock sources
set_ccopt_property cts_is_sdc_clock_root -pin clk true

##############################################################################
##
## Timing connectivity based skew groups: off
##
##############################################################################
set_ccopt_property timing_connectivity_info {}


check_ccopt_clock_tree_convergence
# Restore the ILM status if possible
if { [get_ccopt_property auto_design_state_for_ilms] == 0 } {
  if {$::ccopt::ilm::ccoptSpecRestoreData != {} } {
    eval $::ccopt::ilm::ccoptSpecRestoreData
  }
}

