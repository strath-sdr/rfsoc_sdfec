cd C:/Users/ckb13136/Documents/Git/rfsoc_sdfec_8bit/boards/ip/hdlcoder/book_example/hdl_prj/ipcore/Random_Number_Gen_v1_0/prj_ip
open_project ./prj_ip.xpr
ipx::package_project -root_dir C:/Users/ckb13136/Documents/Git/rfsoc_sdfec_8bit/boards/ip/hdlcoder/book_example/hdl_prj/ipcore/Random_Number_Gen_v1_0/prj_ip -vendor strathsdr.org -library rfsoc_sdfec -taxonomy /UserIP -force
set_property name {Random_Number_Gen} [ipx::current_core]
set_property version {1.0} [ipx::current_core]
set_property display_name {Random Number Gen} [ipx::current_core]
set_property description {HDL Coder generated IP} [ipx::current_core]
set_property company_url {http://strathsdr.org/} [ipx::current_core]
ipx::associate_bus_interfaces -busif m00_axis -clock IPCORE_CLK [ipx::current_core]
ipx::associate_bus_interfaces -busif m01_axis -clock IPCORE_CLK [ipx::current_core]
set_property core_revision 2 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]
ipx::save_core [ipx::current_core]
update_ip_catalog -rebuild -scan_changes
close_project
