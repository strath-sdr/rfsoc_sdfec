# Multicycle constraints for clock enable: Random Number Generator_tc.u1_d16_o0
set enbregcell [get_cells -hier -filter {mcp_info=="Random Number Generator_tc.u1_d16_o0"}]
set enbregnet [get_nets -of_objects [get_pins -of_objects $enbregcell -filter {DIRECTION == OUT}]]
set reglist [get_cells -of [filter [all_fanout -flat -endpoints_only $enbregnet] IS_ENABLE]]
set_multicycle_path 16 -setup -from $reglist -to $reglist -quiet
set_multicycle_path 15 -hold  -from $reglist -to $reglist -quiet

# Multicycle constraints for clock enable: QAM Mapping_tc.u1_d4_o0
set enbregcell [get_cells -hier -filter {mcp_info=="QAM Mapping_tc.u1_d4_o0"}]
set enbregnet [get_nets -of_objects [get_pins -of_objects $enbregcell -filter {DIRECTION == OUT}]]
set reglist [get_cells -of [filter [all_fanout -flat -endpoints_only $enbregnet] IS_ENABLE]]
set_multicycle_path 4 -setup -from $reglist -to $reglist -quiet
set_multicycle_path 3 -hold  -from $reglist -to $reglist -quiet

# Multicycle constraints for clock enable: AWGN Channel_tc.u1_d4_o0
set enbregcell [get_cells -hier -filter {mcp_info=="AWGN Channel_tc.u1_d4_o0"}]
set enbregnet [get_nets -of_objects [get_pins -of_objects $enbregcell -filter {DIRECTION == OUT}]]
set reglist [get_cells -of [filter [all_fanout -flat -endpoints_only $enbregnet] IS_ENABLE]]
set_multicycle_path 4 -setup -from $reglist -to $reglist -quiet
set_multicycle_path 3 -hold  -from $reglist -to $reglist -quiet

