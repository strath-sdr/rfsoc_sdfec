set overlay_name "block_design"
set design_name "strath_sdfec_hw"
set iprepo_dir ./../../ip/iprepo

# Create project
create_project ${overlay_name} ./${overlay_name} -part xczu28dr-ffvg1517-2-e
set_property target_language VHDL [current_project]

# Set IP repository paths
set_property ip_repo_paths $iprepo_dir [current_project]
update_ip_catalog

# Make block design
source ./${design_name}.tcl