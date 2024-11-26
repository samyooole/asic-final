# Source this file within the PDK run directory to import a post-APR GDS
# (GDSPostAPR.gds) into Virtuoso as a design library (with the name
# 'VirtuosoDesignLibName'). 

# The number provided with the switch 'scale' indicates the factor by which
# the post-APR GDS dimensions will be multiplied by when imported into
# Virtuoso. 

# The name provided using the 'topCell' switch must correspond to the
# top-level block name in the synthesized gate level HDL netlist. 

# Supply the correct standard cell/macro library name, referenced during
# the APR, in file strminref.txt. If the referenced standard cell/macro
# library is present within the same PDK run diretory, then the top-cell
# layout in the newly created design library ('VirtuosoDesignLibName') will
# contain cells that point to the referenced standard cell/macro library.
# If this switch is excluded, then all of the macro/standard cells used
# will be created as cell views within the design library.

strmin -library 'dist_sort'  \
-strmFile './asic-final/postapr/dist_sort.gds' \
-attachTechFileOfLib 'asap7_TechLib'  \
-topCell 'dist_sort'  \
-logFile 'strmIn.log'  \
-layerMap '/classes/ece5746/asap7pdk/asap7PDK_e1p5/cdslib/asap7_TechLib_08/asap7_TechLib_08.layermap'  \
-refLibList 'strminref.txt'  \
-objectMap '/classes/ece5746/asap7pdk/asap7PDK_e1p5/cdslib/asap7_TechLib_08/asap7_TechLib_08.objectmap' \
-scale '0.25' 
