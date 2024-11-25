#
# Define variables for stripe layer, width and spacing:

set var(std_cell_overlay_rail_width) 0.072
set var(std_cell_overlay_rail_layer) M2
set var(insert_std_cell_rail_vias) 1
set var(std_cell_rail_via_step) 0.5
set var(row_height) [expr [dbSiteSizeY [dbGetDefaultTechSite]] * [dbgMicronPerDBU]]

# Add the stripes over the existing followpin routing:

setAddStripeMode -stacked_via_bottom_layer M1 \
    -stacked_via_top_layer M2 \
    -allow_nonpreferred_dir stripe \

# part of the techLEF has M1 vertical enclosure. This is good for routing but not here

setViaGenMode -ignore_viarule_enclosure true

# order must be top down or via generation does not work

addStripe \
   -direction horizontal \
   -set_to_set_distance [expr $var(row_height) * 2] \
   -spacing [expr $var(row_height) - $var(std_cell_overlay_rail_width)] \
   -ybottom_offset -[expr $var(std_cell_overlay_rail_width) * 0.5] \
   -ytop_offset -[expr $var(std_cell_overlay_rail_width) * 0.5] \
   -width $var(std_cell_overlay_rail_width) \
   -nets [list vdd vss] \
   -layer M2

addStripe \
   -direction horizontal \
   -set_to_set_distance [expr $var(row_height) * 2] \
   -spacing [expr $var(row_height) - $var(std_cell_overlay_rail_width)] \
   -ybottom_offset -[expr $var(std_cell_overlay_rail_width) * 0.5] \
   -ytop_offset -[expr $var(std_cell_overlay_rail_width) * 0.5] \
   -width $var(std_cell_overlay_rail_width) \
   -nets [list vdd vss] \
   -layer M1

# This only made one via per stripe
# Run editPowerVia to add the other vias between M2 and M1:
#

setViaGenMode -ignore_viarule_enclosure true

editPowerVia \
   -skip_via_on_pin {Pad Block Cover Standardcell} \
   -skip_via_on_wire_shape {Ring Blockring Corewire Blockwire Iowire Padring Fillwire Noshape} \
   -bottom_layer M1 \
   -add_vias 1 \
   -orthogonal_only 0 \
   -top_layer M2


