cd C:/Git/rfsoc_sdfec/boards/ip/hdlcoder/32_bit/hdl_32bits/ipcore/soft_demodulation_v1_0/prj_ip
open_project ./prj_ip.xpr
ipx::package_project -root_dir C:/Git/rfsoc_sdfec/boards/ip/hdlcoder/32_bit/hdl_32bits/ipcore/soft_demodulation_v1_0/prj_ip -vendor strathsdr.org -library rfsoc_sdfec -taxonomy /UserIP -force
set_property name {soft_demodulation} [ipx::current_core]
set_property version {1.0} [ipx::current_core]
set_property display_name {Soft Demodulation} [ipx::current_core]
set_property description {HDL Coder generated IP} [ipx::current_core]
set_property company_url {http://strathsdr.org/} [ipx::current_core]
ipx::associate_bus_interfaces -busif s00_axis_Q -clock IPCORE_CLK [ipx::current_core]
ipx::associate_bus_interfaces -busif s01_axis_Q -clock IPCORE_CLK [ipx::current_core]
ipx::associate_bus_interfaces -busif s00_axis_I -clock IPCORE_CLK [ipx::current_core]
ipx::associate_bus_interfaces -busif s01_axis_I -clock IPCORE_CLK [ipx::current_core]
ipx::associate_bus_interfaces -busif m00_axis -clock IPCORE_CLK [ipx::current_core]
ipx::associate_bus_interfaces -busif m01_axis -clock IPCORE_CLK [ipx::current_core]
ipx::associate_bus_interfaces -busif m02_axis -clock IPCORE_CLK [ipx::current_core]
ipx::associate_bus_interfaces -busif m03_axis -clock IPCORE_CLK [ipx::current_core]
set_property core_revision 2 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]
ipx::save_core [ipx::current_core]
update_ip_catalog -rebuild -scan_changes
close_project
