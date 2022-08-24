
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu28dr-ffvg1517-2-e
   set_property BOARD_PART xilinx.com:zcu111:part0:1.2 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:zynq_ultra_ps_e:3.3\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:sd_fec:1.1\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: ldpc_encoder
proc create_hier_cell_ldpc_encoder { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_ldpc_encoder() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI


  # Create pins
  create_bd_pin -dir I -type clk clk_50M
  create_bd_pin -dir I -type clk clk_667M
  create_bd_pin -dir I -type rst interconnect_reset
  create_bd_pin -dir O -from 4 -to 0 intr
  create_bd_pin -dir I -type rst peripheral_reset

  # Create instance: axi_dma_ctrl, and set properties
  set axi_dma_ctrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_ctrl ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {32} \
   CONFIG.c_m_axis_mm2s_tdata_width {32} \
   CONFIG.c_mm2s_burst_size {16} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_ctrl

  # Create instance: axi_dma_data, and set properties
  set axi_dma_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_data ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {32} \
   CONFIG.c_m_axis_mm2s_tdata_width {8} \
   CONFIG.c_mm2s_burst_size {16} \
   CONFIG.c_s_axis_s2mm_tdata_width {8} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_data

  # Create instance: axi_interconnect_ps_master, and set properties
  set axi_interconnect_ps_master [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_ps_master ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_interconnect_ps_master

  # Create instance: axi_interconnect_ps_slave, and set properties
  set axi_interconnect_ps_slave [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_ps_slave ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {4} \
 ] $axi_interconnect_ps_slave

  # Create instance: axis_rx_fifo, and set properties
  set axis_rx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_rx_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {1} \
 ] $axis_rx_fifo

  # Create instance: axis_tx_fifo, and set properties
  set axis_tx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_tx_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {1} \
 ] $axis_tx_fifo

  # Create instance: sd_fec, and set properties
  set sd_fec [ create_bd_cell -type ip -vlnv xilinx.com:ip:sd_fec:1.1 sd_fec ]
  set_property -dict [ list \
   CONFIG.AXI_WR_Protect {false} \
   CONFIG.Activity {100} \
   CONFIG.Build_SDK_Project {false} \
   CONFIG.Bypass {false} \
   CONFIG.Code_WR_Protect {false} \
   CONFIG.DIN_Interface {Pre-Configured} \
   CONFIG.DIN_Lanes {1} \
   CONFIG.DIN_Words {1} \
   CONFIG.DIN_Words_Configuration {Fixed} \
   CONFIG.DOUT_Interface {Pre-Configured} \
   CONFIG.DOUT_Lanes {1} \
   CONFIG.DOUT_Words {1} \
   CONFIG.DOUT_Words_Configuration {Fixed} \
   CONFIG.DRV_INITIALIZATION_PARAMS {{ 0x00000014,0x00000001,0x0000000C,0x00000000 }} \
   CONFIG.DRV_LDPC_PARAMS {docsis_short_encode {dec_OK 0 enc_OK 1 n 1120 k 840 p 56 nlayers 5 nqc 82 nmqc 44 nm 10 norm_type 1 no_packing 0 special_qc 0 no_final_parity 0 max_schedule 0 sc_table {52428 12} la_table {7 3079 2824 3335 3079} qc_table {132352 65536 134146 134657 131588 131331 142598 140549 137224 137735 131850 131081 139788 132877 142862 428559 0 8961 258 6659 4 2565 4102 4103 8712 1033 522 136971 12 13069 431120 274703 3072 65536 5634 65536 772 7169 13062 11779 6408 4101 4874 519 13324 7433 9486 4619 270864 435985 0 13057 4098 7939 3332 9989 6918 8455 2056 6921 13578 3339 8462 13325 427794 271889 9216 1537 770 13059 1028 4869 1030 11527 12296 2313 5644 2827 11022 5901 265746 426259}} docsis_medium_encode {dec_OK 0 enc_OK 1 n 5940 k 5040 p 180 nlayers 5 nqc 131 nmqc 132 nm 66 norm_type 1 no_packing 0 special_qc 0 no_final_parity 0 max_schedule 0 sc_table {52428 12} la_table {25 3354 4377 3865 3865} qc_table {167424 171521 160002 162819 154628 142341 154886 148999 175112 131849 137482 142347 167180 172045 143886 142607 161296 152593 147475 147988 155925 131350 160535 133144 158745 398876 13824 44033 37122 7171 14084 4869 40710 5639 24584 3081 21770 32780 1293 40462 30735 13072 43793 147730 36115 10773 21270 1815 10009 162074 152603 288028 437021 16128 2817 28674 29187 15620 31493 18438 14087 29192 5129 13578 29195 10764 8461 1038 16911 41744 12817 11794 4371 44820 23576 10522 35355 270877 412190 7168 40961 26114 11267 2052 21509 32262 2311 43272 44553 37642 6155 37132 6670 17170 21011 1044 45333 38678 33559 35608 29977 9242 4635 268062 395295 13312 40705 19202 18947 11780 18181 10758 2823 27656 39177 18443 41741 2319 528 43025 40466 276 12565 22806 16151 45848 2585 19226 41243 307487 398112}} docsis_long_encode {dec_OK 0 enc_OK 1 n 16200 k 14400 p 360 nlayers 5 nqc 169 nmqc 172 nm 135 norm_type 1 no_packing 0 special_qc 0 no_final_parity 1 max_schedule 0 sc_table {52428 12} la_table {32 3617 4385 4385 4385} qc_table {154880 200449 152323 137732 184325 193798 182279 175881 215818 135435 153100 217358 192016 151825 209683 173333 143127 150552 149785 169498 220443 166684 215837 161310 219423 138016 206369 168227 202532 155941 158246 172071 429864 70144 29441 215298 86531 31748 75014 148744 16393 87562 22540 166669 166159 54288 171282 49939 222484 20757 180758 279 40728 14361 18458 32283 70940 39965 8222 28447 44832 209442 57379 52773 7463 289320 478761 34304 90881 44802 6147 64772 61957 47879 24072 6665 22282 77323 48909 82702 5647 62737 75282 61459 21524 19477 87574 88343 44568 68889 84250 54812 55841 26658 10275 50468 18725 58662 16167 331305 411690 47106 17923 63236 3589 5638 1799 72968 13833 90123 6668 27661 2574 76303 31504 35601 29970 86036 12565 51734 91927 87576 57370 27163 69917 45342 62751 25120 90913 45602 45091 37668 71718 318762 446507 64768 69889 23042 38661 79622 81927 86792 75530 37899 12300 23309 15886 25615 59408 37393 51218 34579 3092 45846 59417 5403 84764 80157 89374 8735 24864 47905 9762 60196 13349 43558 14887 327979 393260}} docsis_init_ranging_encode {dec_OK 0 enc_OK 1 n 160 k 80 p 16 nlayers 5 nqc 60 nmqc 16 nm 3 norm_type 1 no_packing 0 special_qc 0 no_final_parity 0 max_schedule 0 sc_table {52428 12} la_table {2 3074 3074 3074 3074} qc_table {65536 65536 65536 65536 131328 133889 65536 65536 132868 428293 133634 134147 65536 65536 65536 65536 512 257 3586 65536 3588 265733 429062 3843 65536 65536 65536 65536 65536 65536 770 515 0 2305 264966 427783 1536 65536 65536 65536 772 65536 65536 2563 427016 2049 65536 264711 3072 65536 65536 65536 4 3329 65536 65536 263432 426505 2818 65536}} docsis_fine_ranging_encode {dec_OK 0 enc_OK 1 n 480 k 288 p 48 nlayers 4 nqc 32 nmqc 16 nm 5 norm_type 1 no_packing 0 special_qc 0 no_final_parity 0 max_schedule 0 sc_table 52428 la_table {3 3075 3075 3075} qc_table {135168 65536 138242 131329 141316 133379 430086 140805 7168 10753 9218 2819 9988 2309 264198 435719 1280 513 4610 4099 6404 12037 430856 262663 4608 4609 10242 4611 4 8709 263944 434185}}} \
   CONFIG.ECC_Interrupts {None} \
   CONFIG.Enable_IFs {false} \
   CONFIG.Enable_Wgt1 {false} \
   CONFIG.Example_Design_PS_Type {ZYNQ_UltraScale+_RFSoC} \
   CONFIG.HDL_INITIALIZATION {{8192 55051360 {K, N}} {8196 20536 {NM, NO_PACKING, PSIZE}} {8200 1071109 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8204 0 {QC_OFF, LA_OFF, SC_OFF}} {65536 52428 SC_TABLE} {65540 12 {}} {98304 7 LA_TABLE} {98308 3079 {}} {98312 2824 {}} {98316 3335 {}} {98320 3079 {}} {131072 132352 QC_TABLE} {131076 65536 {}} {131080 134146 {}} {131084 134657 {}} {131088 131588 {}} {131092 131331 {}} {131096 142598 {}} {131100 140549 {}} {131104 137224 {}} {131108 137735 {}} {131112 131850 {}} {131116 131081 {}} {131120 139788 {}} {131124 132877 {}} {131128 142862 {}} {131132 428559 {}} {131136 0 {}} {131140 8961 {}} {131144 258 {}} {131148 6659 {}} {131152 4 {}} {131156 2565 {}} {131160 4102 {}} {131164 4103 {}} {131168 8712 {}} {131172 1033 {}} {131176 522 {}} {131180 136971 {}} {131184 12 {}} {131188 13069 {}} {131192 431120 {}} {131196 274703 {}} {131200 3072 {}} {131204 65536 {}} {131208 5634 {}} {131212 65536 {}} {131216 772 {}} {131220 7169 {}} {131224 13062 {}} {131228 11779 {}} {131232 6408 {}} {131236 4101 {}} {131240 4874 {}} {131244 519 {}} {131248 13324 {}} {131252 7433 {}} {131256 9486 {}} {131260 4619 {}} {131264 270864 {}} {131268 435985 {}} {131272 0 {}} {131276 13057 {}} {131280 4098 {}} {131284 7939 {}} {131288 3332 {}} {131292 9989 {}} {131296 6918 {}} {131300 8455 {}} {131304 2056 {}} {131308 6921 {}} {131312 13578 {}} {131316 3339 {}} {131320 8462 {}} {131324 13325 {}} {131328 427794 {}} {131332 271889 {}} {131336 9216 {}} {131340 1537 {}} {131344 770 {}} {131348 13059 {}} {131352 1028 {}} {131356 4869 {}} {131360 1030 {}} {131364 11527 {}} {131368 12296 {}} {131372 2313 {}} {131376 5644 {}} {131380 2827 {}} {131384 11022 {}} {131388 5901 {}} {131392 265746 {}} {131396 426259 {}} {8208 330307380 {K, N}} {8212 135348 {NM, NO_PACKING, PSIZE}} {8216 1116165 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8220 1376770 {QC_OFF, LA_OFF, SC_OFF}} {65544 52428 SC_TABLE} {65548 12 {}} {98336 25 LA_TABLE} {98340 3354 {}} {98344 4377 {}} {98348 3865 {}} {98352 3865 {}} {131408 167424 QC_TABLE} {131412 171521 {}} {131416 160002 {}} {131420 162819 {}} {131424 154628 {}} {131428 142341 {}} {131432 154886 {}} {131436 148999 {}} {131440 175112 {}} {131444 131849 {}} {131448 137482 {}} {131452 142347 {}} {131456 167180 {}} {131460 172045 {}} {131464 143886 {}} {131468 142607 {}} {131472 161296 {}} {131476 152593 {}} {131480 147475 {}} {131484 147988 {}} {131488 155925 {}} {131492 131350 {}} {131496 160535 {}} {131500 133144 {}} {131504 158745 {}} {131508 398876 {}} {131512 13824 {}} {131516 44033 {}} {131520 37122 {}} {131524 7171 {}} {131528 14084 {}} {131532 4869 {}} {131536 40710 {}} {131540 5639 {}} {131544 24584 {}} {131548 3081 {}} {131552 21770 {}} {131556 32780 {}} {131560 1293 {}} {131564 40462 {}} {131568 30735 {}} {131572 13072 {}} {131576 43793 {}} {131580 147730 {}} {131584 36115 {}} {131588 10773 {}} {131592 21270 {}} {131596 1815 {}} {131600 10009 {}} {131604 162074 {}} {131608 152603 {}} {131612 288028 {}} {131616 437021 {}} {131620 16128 {}} {131624 2817 {}} {131628 28674 {}} {131632 29187 {}} {131636 15620 {}} {131640 31493 {}} {131644 18438 {}} {131648 14087 {}} {131652 29192 {}} {131656 5129 {}} {131660 13578 {}} {131664 29195 {}} {131668 10764 {}} {131672 8461 {}} {131676 1038 {}} {131680 16911 {}} {131684 41744 {}} {131688 12817 {}} {131692 11794 {}} {131696 4371 {}} {131700 44820 {}} {131704 23576 {}} {131708 10522 {}} {131712 35355 {}} {131716 270877 {}} {131720 412190 {}} {131724 7168 {}} {131728 40961 {}} {131732 26114 {}} {131736 11267 {}} {131740 2052 {}} {131744 21509 {}} {131748 32262 {}} {131752 2311 {}} {131756 43272 {}} {131760 44553 {}} {131764 37642 {}} {131768 6155 {}} {131772 37132 {}} {131776 6670 {}} {131780 17170 {}} {131784 21011 {}} {131788 1044 {}} {131792 45333 {}} {131796 38678 {}} {131800 33559 {}} {131804 35608 {}} {131808 29977 {}} {131812 9242 {}} {131816 4635 {}} {131820 268062 {}} {131824 395295 {}} {131828 13312 {}} {131832 40705 {}} {131836 19202 {}} {131840 18947 {}} {131844 11780 {}} {131848 18181 {}} {131852 10758 {}} {131856 2823 {}} {131860 27656 {}} {131864 39177 {}} {131868 18443 {}} {131872 41741 {}} {131876 2319 {}} {131880 528 {}} {131884 43025 {}} {131888 40466 {}} {131892 276 {}} {131896 12565 {}} {131900 22806 {}} {131904 16151 {}} {131908 45848 {}} {131912 2585 {}} {131916 19226 {}} {131920 41243 {}} {131924 307487 {}} {131928 398112 {}} {8224 943734600 {K, N}} {8228 276840 {NM, NO_PACKING, PSIZE}} {8232 5330949 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8236 3539972 {QC_OFF, LA_OFF, SC_OFF}} {65552 52428 SC_TABLE} {65556 12 {}} {98368 32 LA_TABLE} {98372 3617 {}} {98376 4385 {}} {98380 4385 {}} {98384 4385 {}} {131936 154880 QC_TABLE} {131940 200449 {}} {131944 152323 {}} {131948 137732 {}} {131952 184325 {}} {131956 193798 {}} {131960 182279 {}} {131964 175881 {}} {131968 215818 {}} {131972 135435 {}} {131976 153100 {}} {131980 217358 {}} {131984 192016 {}} {131988 151825 {}} {131992 209683 {}} {131996 173333 {}} {132000 143127 {}} {132004 150552 {}} {132008 149785 {}} {132012 169498 {}} {132016 220443 {}} {132020 166684 {}} {132024 215837 {}} {132028 161310 {}} {132032 219423 {}} {132036 138016 {}} {132040 206369 {}} {132044 168227 {}} {132048 202532 {}} {132052 155941 {}} {132056 158246 {}} {132060 172071 {}} {132064 429864 {}} {132068 70144 {}} {132072 29441 {}} {132076 215298 {}} {132080 86531 {}} {132084 31748 {}} {132088 75014 {}} {132092 148744 {}} {132096 16393 {}} {132100 87562 {}} {132104 22540 {}} {132108 166669 {}} {132112 166159 {}} {132116 54288 {}} {132120 171282 {}} {132124 49939 {}} {132128 222484 {}} {132132 20757 {}} {132136 180758 {}} {132140 279 {}} {132144 40728 {}} {132148 14361 {}} {132152 18458 {}} {132156 32283 {}} {132160 70940 {}} {132164 39965 {}} {132168 8222 {}} {132172 28447 {}} {132176 44832 {}} {132180 209442 {}} {132184 57379 {}} {132188 52773 {}} {132192 7463 {}} {132196 289320 {}} {132200 478761 {}} {132204 34304 {}} {132208 90881 {}} {132212 44802 {}} {132216 6147 {}} {132220 64772 {}} {132224 61957 {}} {132228 47879 {}} {132232 24072 {}} {132236 6665 {}} {132240 22282 {}} {132244 77323 {}} {132248 48909 {}} {132252 82702 {}} {132256 5647 {}} {132260 62737 {}} {132264 75282 {}} {132268 61459 {}} {132272 21524 {}} {132276 19477 {}} {132280 87574 {}} {132284 88343 {}} {132288 44568 {}} {132292 68889 {}} {132296 84250 {}} {132300 54812 {}} {132304 55841 {}} {132308 26658 {}} {132312 10275 {}} {132316 50468 {}} {132320 18725 {}} {132324 58662 {}} {132328 16167 {}} {132332 331305 {}} {132336 411690 {}} {132340 47106 {}} {132344 17923 {}} {132348 63236 {}} {132352 3589 {}} {132356 5638 {}} {132360 1799 {}} {132364 72968 {}} {132368 13833 {}} {132372 90123 {}} {132376 6668 {}} {132380 27661 {}} {132384 2574 {}} {132388 76303 {}} {132392 31504 {}} {132396 35601 {}} {132400 29970 {}} {132404 86036 {}} {132408 12565 {}} {132412 51734 {}} {132416 91927 {}} {132420 87576 {}} {132424 57370 {}} {132428 27163 {}} {132432 69917 {}} {132436 45342 {}} {132440 62751 {}} {132444 25120 {}} {132448 90913 {}} {132452 45602 {}} {132456 45091 {}} {132460 37668 {}} {132464 71718 {}} {132468 318762 {}} {132472 446507 {}} {132476 64768 {}} {132480 69889 {}} {132484 23042 {}} {132488 38661 {}} {132492 79622 {}} {132496 81927 {}} {132500 86792 {}} {132504 75530 {}} {132508 37899 {}} {132512 12300 {}} {132516 23309 {}} {132520 15886 {}} {132524 25615 {}} {132528 59408 {}} {132532 37393 {}} {132536 51218 {}} {132540 34579 {}} {132544 3092 {}} {132548 45846 {}} {132552 59417 {}} {132556 5403 {}} {132560 84764 {}} {132564 80157 {}} {132568 89374 {}} {132572 8735 {}} {132576 24864 {}} {132580 47905 {}} {132584 9762 {}} {132588 60196 {}} {132592 13349 {}} {132596 43558 {}} {132600 14887 {}} {132604 327979 {}} {132608 393260 {}} {8240 5243040 {K, N}} {8244 6160 {NM, NO_PACKING, PSIZE}} {8248 1056773 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8252 6358534 {QC_OFF, LA_OFF, SC_OFF}} {65560 52428 SC_TABLE} {65564 12 {}} {98400 2 LA_TABLE} {98404 3074 {}} {98408 3074 {}} {98412 3074 {}} {98416 3074 {}} {132624 65536 QC_TABLE} {132628 65536 {}} {132632 65536 {}} {132636 65536 {}} {132640 131328 {}} {132644 133889 {}} {132648 65536 {}} {132652 65536 {}} {132656 132868 {}} {132660 428293 {}} {132664 133634 {}} {132668 134147 {}} {132672 65536 {}} {132676 65536 {}} {132680 65536 {}} {132684 65536 {}} {132688 512 {}} {132692 257 {}} {132696 3586 {}} {132700 65536 {}} {132704 3588 {}} {132708 265733 {}} {132712 429062 {}} {132716 3843 {}} {132720 65536 {}} {132724 65536 {}} {132728 65536 {}} {132732 65536 {}} {132736 65536 {}} {132740 65536 {}} {132744 770 {}} {132748 515 {}} {132752 0 {}} {132756 2305 {}} {132760 264966 {}} {132764 427783 {}} {132768 1536 {}} {132772 65536 {}} {132776 65536 {}} {132780 65536 {}} {132784 772 {}} {132788 65536 {}} {132792 65536 {}} {132796 2563 {}} {132800 427016 {}} {132804 2049 {}} {132808 65536 {}} {132812 264711 {}} {132816 3072 {}} {132820 65536 {}} {132824 65536 {}} {132828 65536 {}} {132832 4 {}} {132836 3329 {}} {132840 65536 {}} {132844 65536 {}} {132848 263432 {}} {132852 426505 {}} {132856 2818 {}} {132860 65536 {}} {8256 18874848 {K, N}} {8260 10288 {NM, NO_PACKING, PSIZE}} {8264 1056772 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8268 7342088 {QC_OFF, LA_OFF, SC_OFF}} {65568 52428 SC_TABLE} {98432 3 LA_TABLE} {98436 3075 {}} {98440 3075 {}} {98444 3075 {}} {132864 135168 QC_TABLE} {132868 65536 {}} {132872 138242 {}} {132876 131329 {}} {132880 141316 {}} {132884 133379 {}} {132888 430086 {}} {132892 140805 {}} {132896 7168 {}} {132900 10753 {}} {132904 9218 {}} {132908 2819 {}} {132912 9988 {}} {132916 2309 {}} {132920 264198 {}} {132924 435719 {}} {132928 1280 {}} {132932 513 {}} {132936 4610 {}} {132940 4099 {}} {132944 6404 {}} {132948 12037 {}} {132952 430856 {}} {132956 262663 {}} {132960 4608 {}} {132964 4609 {}} {132968 10242 {}} {132972 4611 {}} {132976 4 {}} {132980 8709 {}} {132984 263944 {}} {132988 434185 {}} {20 1 FEC_CODE} {12 0 AXIS_WIDTH}} \
   CONFIG.Include_Encoder {false} \
   CONFIG.Include_PS_Example_Design {false} \
   CONFIG.Interrupts {false} \
   CONFIG.LDPC_Decode {false} \
   CONFIG.LDPC_Decode_Max_Schedule {0} \
   CONFIG.LDPC_Decode_No_OPC {false} \
   CONFIG.LDPC_Decode_Overrides {false} \
   CONFIG.LDPC_Decode_Scale {12} \
   CONFIG.LDPC_Encode {true} \
   CONFIG.LDPC_Encode_Code_Definition {../../../../../../../../all_codes.txt} \
   CONFIG.LD_PERCENT_LOAD {0} \
   CONFIG.LE_PERCENT_LOAD {100} \
   CONFIG.Out_of_Order {false} \
   CONFIG.Parameter_Interface {Runtime-Configured} \
   CONFIG.Percentage_Loading {Automatic} \
   CONFIG.Physical_Utilization {100} \
   CONFIG.Standard {DOCSIS_3.1} \
   CONFIG.Turbo_Decode {false} \
   CONFIG.Turbo_Decode_Algorithm {MaxScale} \
   CONFIG.Turbo_Decode_Scale {12} \
 ] $sd_fec

  # Create instance: xlconcat_intr, and set properties
  set xlconcat_intr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_intr ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {5} \
 ] $xlconcat_intr

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_interconnect_ps_slave/M00_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_interconnect_ps_master/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_ctrl_M_AXIS_MM2S [get_bd_intf_pins axi_dma_ctrl/M_AXIS_MM2S] [get_bd_intf_pins sd_fec/S_AXIS_CTRL]
  connect_bd_intf_net -intf_net axi_dma_ctrl_M_AXI_MM2S [get_bd_intf_pins axi_dma_ctrl/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_ps_slave/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_ctrl_M_AXI_S2MM [get_bd_intf_pins axi_dma_ctrl/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_ps_slave/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_data_M_AXIS_MM2S [get_bd_intf_pins axi_dma_data/M_AXIS_MM2S] [get_bd_intf_pins axis_tx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net axi_dma_data_M_AXI_MM2S [get_bd_intf_pins axi_dma_data/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_ps_slave/S02_AXI]
  connect_bd_intf_net -intf_net axi_dma_data_M_AXI_S2MM [get_bd_intf_pins axi_dma_data/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_ps_slave/S03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_dma_ctrl/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_ps_master/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_dma_data/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_ps_master/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_interconnect_ps_master/M02_AXI] [get_bd_intf_pins sd_fec/S_AXI]
  connect_bd_intf_net -intf_net axis_rx_fifo_M_AXIS [get_bd_intf_pins axi_dma_data/S_AXIS_S2MM] [get_bd_intf_pins axis_rx_fifo/M_AXIS]
  connect_bd_intf_net -intf_net axis_tx_fifo_M_AXIS [get_bd_intf_pins axis_tx_fifo/M_AXIS] [get_bd_intf_pins sd_fec/S_AXIS_DIN]
  connect_bd_intf_net -intf_net sd_fec_M_AXIS_DOUT [get_bd_intf_pins axis_rx_fifo/S_AXIS] [get_bd_intf_pins sd_fec/M_AXIS_DOUT]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins interconnect_reset] [get_bd_pins axi_interconnect_ps_master/ARESETN] [get_bd_pins axi_interconnect_ps_slave/ARESETN]
  connect_bd_net -net axi_dma_ctrl_mm2s_introut [get_bd_pins axi_dma_ctrl/mm2s_introut] [get_bd_pins xlconcat_intr/In0]
  connect_bd_net -net axi_dma_ctrl_s2mm_introut [get_bd_pins axi_dma_ctrl/s2mm_introut] [get_bd_pins xlconcat_intr/In1]
  connect_bd_net -net axi_dma_ctrl_s_axis_s2mm_tready [get_bd_pins axi_dma_ctrl/s_axis_s2mm_tready] [get_bd_pins sd_fec/m_axis_status_tready]
  connect_bd_net -net axi_dma_data_mm2s_introut [get_bd_pins axi_dma_data/mm2s_introut] [get_bd_pins xlconcat_intr/In2]
  connect_bd_net -net axi_dma_data_s2mm_introut [get_bd_pins axi_dma_data/s2mm_introut] [get_bd_pins xlconcat_intr/In3]
  connect_bd_net -net clk_wiz_0_clk_667M [get_bd_pins clk_667M] [get_bd_pins sd_fec/core_clk]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_50M] [get_bd_pins axi_dma_ctrl/m_axi_mm2s_aclk] [get_bd_pins axi_dma_ctrl/m_axi_s2mm_aclk] [get_bd_pins axi_dma_ctrl/s_axi_lite_aclk] [get_bd_pins axi_dma_data/m_axi_mm2s_aclk] [get_bd_pins axi_dma_data/m_axi_s2mm_aclk] [get_bd_pins axi_dma_data/s_axi_lite_aclk] [get_bd_pins axi_interconnect_ps_master/ACLK] [get_bd_pins axi_interconnect_ps_master/M00_ACLK] [get_bd_pins axi_interconnect_ps_master/M01_ACLK] [get_bd_pins axi_interconnect_ps_master/M02_ACLK] [get_bd_pins axi_interconnect_ps_master/S00_ACLK] [get_bd_pins axi_interconnect_ps_slave/ACLK] [get_bd_pins axi_interconnect_ps_slave/M00_ACLK] [get_bd_pins axi_interconnect_ps_slave/S00_ACLK] [get_bd_pins axi_interconnect_ps_slave/S01_ACLK] [get_bd_pins axi_interconnect_ps_slave/S02_ACLK] [get_bd_pins axi_interconnect_ps_slave/S03_ACLK] [get_bd_pins axis_rx_fifo/s_axis_aclk] [get_bd_pins axis_tx_fifo/s_axis_aclk] [get_bd_pins sd_fec/m_axis_dout_aclk] [get_bd_pins sd_fec/m_axis_status_aclk] [get_bd_pins sd_fec/s_axi_aclk] [get_bd_pins sd_fec/s_axis_ctrl_aclk] [get_bd_pins sd_fec/s_axis_din_aclk]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins peripheral_reset] [get_bd_pins axi_dma_ctrl/axi_resetn] [get_bd_pins axi_dma_data/axi_resetn] [get_bd_pins axi_interconnect_ps_master/M00_ARESETN] [get_bd_pins axi_interconnect_ps_master/M01_ARESETN] [get_bd_pins axi_interconnect_ps_master/M02_ARESETN] [get_bd_pins axi_interconnect_ps_master/S00_ARESETN] [get_bd_pins axi_interconnect_ps_slave/M00_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S00_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S01_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S02_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S03_ARESETN] [get_bd_pins axis_rx_fifo/s_axis_aresetn] [get_bd_pins axis_tx_fifo/s_axis_aresetn] [get_bd_pins sd_fec/reset_n]
  connect_bd_net -net sd_fec_interrupt [get_bd_pins sd_fec/interrupt] [get_bd_pins xlconcat_intr/In4]
  connect_bd_net -net sd_fec_m_axis_status_tdata [get_bd_pins axi_dma_ctrl/s_axis_s2mm_tdata] [get_bd_pins sd_fec/m_axis_status_tdata]
  connect_bd_net -net sd_fec_m_axis_status_tvalid [get_bd_pins axi_dma_ctrl/s_axis_s2mm_tlast] [get_bd_pins axi_dma_ctrl/s_axis_s2mm_tvalid] [get_bd_pins sd_fec/m_axis_status_tvalid]
  connect_bd_net -net xlconcat_intr_dout [get_bd_pins intr] [get_bd_pins xlconcat_intr/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: ldpc_decoder
proc create_hier_cell_ldpc_decoder { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_ldpc_decoder() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI


  # Create pins
  create_bd_pin -dir I -type clk clk_50M
  create_bd_pin -dir I -type clk clk_667M
  create_bd_pin -dir I -type rst interconnect_reset
  create_bd_pin -dir O -from 4 -to 0 intr
  create_bd_pin -dir I -type rst peripheral_reset

  # Create instance: axi_dma_ctrl, and set properties
  set axi_dma_ctrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_ctrl ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {32} \
   CONFIG.c_m_axis_mm2s_tdata_width {32} \
   CONFIG.c_mm2s_burst_size {16} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_ctrl

  # Create instance: axi_dma_data, and set properties
  set axi_dma_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_data ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axis_mm2s_tdata_width {8} \
   CONFIG.c_s_axis_s2mm_tdata_width {8} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_data

  # Create instance: axi_interconnect_ps_master, and set properties
  set axi_interconnect_ps_master [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_ps_master ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_interconnect_ps_master

  # Create instance: axi_interconnect_ps_slave, and set properties
  set axi_interconnect_ps_slave [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_ps_slave ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {4} \
 ] $axi_interconnect_ps_slave

  # Create instance: axis_rx_fifo, and set properties
  set axis_rx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_rx_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {1} \
 ] $axis_rx_fifo

  # Create instance: axis_tx_fifo, and set properties
  set axis_tx_fifo [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_tx_fifo ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.TDATA_NUM_BYTES {1} \
 ] $axis_tx_fifo

  # Create instance: sd_fec, and set properties
  set sd_fec [ create_bd_cell -type ip -vlnv xilinx.com:ip:sd_fec:1.1 sd_fec ]
  set_property -dict [ list \
   CONFIG.AXI_WR_Protect {false} \
   CONFIG.Activity {100} \
   CONFIG.Build_SDK_Project {false} \
   CONFIG.Bypass {false} \
   CONFIG.Code_WR_Protect {false} \
   CONFIG.DIN_Interface {Pre-Configured} \
   CONFIG.DIN_Lanes {1} \
   CONFIG.DIN_Words {1} \
   CONFIG.DIN_Words_Configuration {Fixed} \
   CONFIG.DOUT_Interface {Pre-Configured} \
   CONFIG.DOUT_Lanes {1} \
   CONFIG.DOUT_Words {1} \
   CONFIG.DOUT_Words_Configuration {Fixed} \
   CONFIG.DRV_INITIALIZATION_PARAMS {{ 0x00000014,0x00000001,0x0000000C,0x00000000 }} \
   CONFIG.DRV_LDPC_PARAMS {docsis_short {dec_OK 1 enc_OK 1 n 1120 k 840 p 56 nlayers 5 nqc 82 nmqc 44 nm 10 norm_type 1 no_packing 0 special_qc 0 no_final_parity 0 max_schedule 0 sc_table {52428 12} la_table {3079 3335 3080 3591 3079} qc_table {132352 65536 134146 134657 131588 131331 142598 140549 137224 137735 131850 131081 139788 132877 142862 428559 0 8961 258 6659 4 2565 4102 4103 8712 1033 522 136971 12 13069 431120 274703 3072 65536 5634 65536 772 7169 13062 11779 6408 4101 4874 519 13324 7433 9486 4619 270864 435985 0 13057 4098 7939 3332 9989 6918 8455 2056 6921 13578 3339 8462 13325 427794 271889 9216 1537 770 13059 1028 4869 1030 11527 12296 2313 5644 2827 11022 5901 265746 426259}} docsis_medium {dec_OK 1 enc_OK 1 n 5940 k 5040 p 180 nlayers 5 nqc 131 nmqc 132 nm 66 norm_type 1 no_packing 0 special_qc 0 no_final_parity 0 max_schedule 0 sc_table {52428 12} la_table {3353 4378 4377 5401 3865} qc_table {167424 171521 160002 162819 154628 142341 154886 148999 175112 131849 137482 142347 167180 172045 143886 142607 161296 152593 147475 147988 155925 131350 160535 133144 158745 398876 13824 44033 37122 7171 14084 4869 40710 5639 24584 3081 21770 32780 1293 40462 30735 13072 43793 147730 36115 10773 21270 1815 10009 162074 152603 288028 437021 16128 2817 28674 29187 15620 31493 18438 14087 29192 5129 13578 29195 10764 8461 1038 16911 41744 12817 11794 4371 44820 23576 10522 35355 270877 412190 7168 40961 26114 11267 2052 21509 32262 2311 43272 44553 37642 6155 37132 6670 17170 21011 1044 45333 38678 33559 35608 29977 9242 4635 268062 395295 13312 40705 19202 18947 11780 18181 10758 2823 27656 39177 18443 41741 2319 528 43025 40466 276 12565 22806 16151 45848 2585 19226 41243 307487 398112}} docsis_long {dec_OK 1 enc_OK 1 n 16200 k 14400 p 360 nlayers 5 nqc 169 nmqc 172 nm 135 norm_type 1 no_packing 0 special_qc 0 no_final_parity 1 max_schedule 0 sc_table {52428 12} la_table {5152 4385 5153 5153 5153} qc_table {154880 200449 152323 137732 184325 193798 182279 175881 215818 135435 153100 217358 192016 151825 209683 173333 143127 150552 149785 169498 220443 166684 215837 161310 219423 138016 206369 168227 202532 155941 158246 172071 429864 70144 29441 215298 86531 31748 75014 148744 16393 87562 22540 166669 166159 54288 171282 49939 222484 20757 180758 279 40728 14361 18458 32283 70940 39965 8222 28447 44832 209442 57379 52773 7463 289320 478761 34304 90881 44802 6147 64772 61957 47879 24072 6665 22282 77323 48909 82702 5647 62737 75282 61459 21524 19477 87574 88343 44568 68889 84250 54812 55841 26658 10275 50468 18725 58662 16167 331305 411690 47106 17923 63236 3589 5638 1799 72968 13833 90123 6668 27661 2574 76303 31504 35601 29970 86036 12565 51734 91927 87576 57370 27163 69917 45342 62751 25120 90913 45602 45091 37668 71718 318762 446507 64768 69889 23042 38661 79622 81927 86792 75530 37899 12300 23309 15886 25615 59408 37393 51218 34579 3092 45846 59417 5403 84764 80157 89374 8735 24864 47905 9762 60196 13349 43558 14887 327979 393260}} docsis_init_ranging {dec_OK 1 enc_OK 1 n 160 k 80 p 16 nlayers 5 nqc 60 nmqc 16 nm 3 norm_type 1 no_packing 0 special_qc 0 no_final_parity 0 max_schedule 0 sc_table {52428 12} la_table {3074 3330 3330 3586 3330} qc_table {65536 65536 65536 65536 131328 133889 65536 65536 132868 428293 133634 134147 65536 65536 65536 65536 512 257 3586 65536 3588 265733 429062 3843 65536 65536 65536 65536 65536 65536 770 515 0 2305 264966 427783 1536 65536 65536 65536 772 65536 65536 2563 427016 2049 65536 264711 3072 65536 65536 65536 4 3329 65536 65536 263432 426505 2818 65536}} docsis_fine_ranging {dec_OK 1 enc_OK 1 n 480 k 288 p 48 nlayers 4 nqc 32 nmqc 16 nm 5 norm_type 1 no_packing 0 special_qc 0 no_final_parity 0 max_schedule 0 sc_table 52428 la_table {3075 3331 3075 3075} qc_table {135168 65536 138242 131329 141316 133379 430086 140805 7168 10753 9218 2819 9988 2309 264198 435719 1280 513 4610 4099 6404 12037 430856 262663 4608 4609 10242 4611 4 8709 263944 434185}}} \
   CONFIG.ECC_Interrupts {None} \
   CONFIG.Enable_IFs {false} \
   CONFIG.Enable_Wgt1 {false} \
   CONFIG.Example_Design_PS_Type {ZYNQ_UltraScale+_RFSoC} \
   CONFIG.HDL_INITIALIZATION {{8192 55051360 {K, N}} {8196 20536 {NM, NO_PACKING, PSIZE}} {8200 1071109 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8204 0 {QC_OFF, LA_OFF, SC_OFF}} {65536 52428 SC_TABLE} {65540 12 {}} {98304 3079 LA_TABLE} {98308 3335 {}} {98312 3080 {}} {98316 3591 {}} {98320 3079 {}} {131072 132352 QC_TABLE} {131076 65536 {}} {131080 134146 {}} {131084 134657 {}} {131088 131588 {}} {131092 131331 {}} {131096 142598 {}} {131100 140549 {}} {131104 137224 {}} {131108 137735 {}} {131112 131850 {}} {131116 131081 {}} {131120 139788 {}} {131124 132877 {}} {131128 142862 {}} {131132 428559 {}} {131136 0 {}} {131140 8961 {}} {131144 258 {}} {131148 6659 {}} {131152 4 {}} {131156 2565 {}} {131160 4102 {}} {131164 4103 {}} {131168 8712 {}} {131172 1033 {}} {131176 522 {}} {131180 136971 {}} {131184 12 {}} {131188 13069 {}} {131192 431120 {}} {131196 274703 {}} {131200 3072 {}} {131204 65536 {}} {131208 5634 {}} {131212 65536 {}} {131216 772 {}} {131220 7169 {}} {131224 13062 {}} {131228 11779 {}} {131232 6408 {}} {131236 4101 {}} {131240 4874 {}} {131244 519 {}} {131248 13324 {}} {131252 7433 {}} {131256 9486 {}} {131260 4619 {}} {131264 270864 {}} {131268 435985 {}} {131272 0 {}} {131276 13057 {}} {131280 4098 {}} {131284 7939 {}} {131288 3332 {}} {131292 9989 {}} {131296 6918 {}} {131300 8455 {}} {131304 2056 {}} {131308 6921 {}} {131312 13578 {}} {131316 3339 {}} {131320 8462 {}} {131324 13325 {}} {131328 427794 {}} {131332 271889 {}} {131336 9216 {}} {131340 1537 {}} {131344 770 {}} {131348 13059 {}} {131352 1028 {}} {131356 4869 {}} {131360 1030 {}} {131364 11527 {}} {131368 12296 {}} {131372 2313 {}} {131376 5644 {}} {131380 2827 {}} {131384 11022 {}} {131388 5901 {}} {131392 265746 {}} {131396 426259 {}} {8208 330307380 {K, N}} {8212 135348 {NM, NO_PACKING, PSIZE}} {8216 1116165 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8220 1376770 {QC_OFF, LA_OFF, SC_OFF}} {65544 52428 SC_TABLE} {65548 12 {}} {98336 3353 LA_TABLE} {98340 4378 {}} {98344 4377 {}} {98348 5401 {}} {98352 3865 {}} {131408 167424 QC_TABLE} {131412 171521 {}} {131416 160002 {}} {131420 162819 {}} {131424 154628 {}} {131428 142341 {}} {131432 154886 {}} {131436 148999 {}} {131440 175112 {}} {131444 131849 {}} {131448 137482 {}} {131452 142347 {}} {131456 167180 {}} {131460 172045 {}} {131464 143886 {}} {131468 142607 {}} {131472 161296 {}} {131476 152593 {}} {131480 147475 {}} {131484 147988 {}} {131488 155925 {}} {131492 131350 {}} {131496 160535 {}} {131500 133144 {}} {131504 158745 {}} {131508 398876 {}} {131512 13824 {}} {131516 44033 {}} {131520 37122 {}} {131524 7171 {}} {131528 14084 {}} {131532 4869 {}} {131536 40710 {}} {131540 5639 {}} {131544 24584 {}} {131548 3081 {}} {131552 21770 {}} {131556 32780 {}} {131560 1293 {}} {131564 40462 {}} {131568 30735 {}} {131572 13072 {}} {131576 43793 {}} {131580 147730 {}} {131584 36115 {}} {131588 10773 {}} {131592 21270 {}} {131596 1815 {}} {131600 10009 {}} {131604 162074 {}} {131608 152603 {}} {131612 288028 {}} {131616 437021 {}} {131620 16128 {}} {131624 2817 {}} {131628 28674 {}} {131632 29187 {}} {131636 15620 {}} {131640 31493 {}} {131644 18438 {}} {131648 14087 {}} {131652 29192 {}} {131656 5129 {}} {131660 13578 {}} {131664 29195 {}} {131668 10764 {}} {131672 8461 {}} {131676 1038 {}} {131680 16911 {}} {131684 41744 {}} {131688 12817 {}} {131692 11794 {}} {131696 4371 {}} {131700 44820 {}} {131704 23576 {}} {131708 10522 {}} {131712 35355 {}} {131716 270877 {}} {131720 412190 {}} {131724 7168 {}} {131728 40961 {}} {131732 26114 {}} {131736 11267 {}} {131740 2052 {}} {131744 21509 {}} {131748 32262 {}} {131752 2311 {}} {131756 43272 {}} {131760 44553 {}} {131764 37642 {}} {131768 6155 {}} {131772 37132 {}} {131776 6670 {}} {131780 17170 {}} {131784 21011 {}} {131788 1044 {}} {131792 45333 {}} {131796 38678 {}} {131800 33559 {}} {131804 35608 {}} {131808 29977 {}} {131812 9242 {}} {131816 4635 {}} {131820 268062 {}} {131824 395295 {}} {131828 13312 {}} {131832 40705 {}} {131836 19202 {}} {131840 18947 {}} {131844 11780 {}} {131848 18181 {}} {131852 10758 {}} {131856 2823 {}} {131860 27656 {}} {131864 39177 {}} {131868 18443 {}} {131872 41741 {}} {131876 2319 {}} {131880 528 {}} {131884 43025 {}} {131888 40466 {}} {131892 276 {}} {131896 12565 {}} {131900 22806 {}} {131904 16151 {}} {131908 45848 {}} {131912 2585 {}} {131916 19226 {}} {131920 41243 {}} {131924 307487 {}} {131928 398112 {}} {8224 943734600 {K, N}} {8228 276840 {NM, NO_PACKING, PSIZE}} {8232 5330949 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8236 3539972 {QC_OFF, LA_OFF, SC_OFF}} {65552 52428 SC_TABLE} {65556 12 {}} {98368 5152 LA_TABLE} {98372 4385 {}} {98376 5153 {}} {98380 5153 {}} {98384 5153 {}} {131936 154880 QC_TABLE} {131940 200449 {}} {131944 152323 {}} {131948 137732 {}} {131952 184325 {}} {131956 193798 {}} {131960 182279 {}} {131964 175881 {}} {131968 215818 {}} {131972 135435 {}} {131976 153100 {}} {131980 217358 {}} {131984 192016 {}} {131988 151825 {}} {131992 209683 {}} {131996 173333 {}} {132000 143127 {}} {132004 150552 {}} {132008 149785 {}} {132012 169498 {}} {132016 220443 {}} {132020 166684 {}} {132024 215837 {}} {132028 161310 {}} {132032 219423 {}} {132036 138016 {}} {132040 206369 {}} {132044 168227 {}} {132048 202532 {}} {132052 155941 {}} {132056 158246 {}} {132060 172071 {}} {132064 429864 {}} {132068 70144 {}} {132072 29441 {}} {132076 215298 {}} {132080 86531 {}} {132084 31748 {}} {132088 75014 {}} {132092 148744 {}} {132096 16393 {}} {132100 87562 {}} {132104 22540 {}} {132108 166669 {}} {132112 166159 {}} {132116 54288 {}} {132120 171282 {}} {132124 49939 {}} {132128 222484 {}} {132132 20757 {}} {132136 180758 {}} {132140 279 {}} {132144 40728 {}} {132148 14361 {}} {132152 18458 {}} {132156 32283 {}} {132160 70940 {}} {132164 39965 {}} {132168 8222 {}} {132172 28447 {}} {132176 44832 {}} {132180 209442 {}} {132184 57379 {}} {132188 52773 {}} {132192 7463 {}} {132196 289320 {}} {132200 478761 {}} {132204 34304 {}} {132208 90881 {}} {132212 44802 {}} {132216 6147 {}} {132220 64772 {}} {132224 61957 {}} {132228 47879 {}} {132232 24072 {}} {132236 6665 {}} {132240 22282 {}} {132244 77323 {}} {132248 48909 {}} {132252 82702 {}} {132256 5647 {}} {132260 62737 {}} {132264 75282 {}} {132268 61459 {}} {132272 21524 {}} {132276 19477 {}} {132280 87574 {}} {132284 88343 {}} {132288 44568 {}} {132292 68889 {}} {132296 84250 {}} {132300 54812 {}} {132304 55841 {}} {132308 26658 {}} {132312 10275 {}} {132316 50468 {}} {132320 18725 {}} {132324 58662 {}} {132328 16167 {}} {132332 331305 {}} {132336 411690 {}} {132340 47106 {}} {132344 17923 {}} {132348 63236 {}} {132352 3589 {}} {132356 5638 {}} {132360 1799 {}} {132364 72968 {}} {132368 13833 {}} {132372 90123 {}} {132376 6668 {}} {132380 27661 {}} {132384 2574 {}} {132388 76303 {}} {132392 31504 {}} {132396 35601 {}} {132400 29970 {}} {132404 86036 {}} {132408 12565 {}} {132412 51734 {}} {132416 91927 {}} {132420 87576 {}} {132424 57370 {}} {132428 27163 {}} {132432 69917 {}} {132436 45342 {}} {132440 62751 {}} {132444 25120 {}} {132448 90913 {}} {132452 45602 {}} {132456 45091 {}} {132460 37668 {}} {132464 71718 {}} {132468 318762 {}} {132472 446507 {}} {132476 64768 {}} {132480 69889 {}} {132484 23042 {}} {132488 38661 {}} {132492 79622 {}} {132496 81927 {}} {132500 86792 {}} {132504 75530 {}} {132508 37899 {}} {132512 12300 {}} {132516 23309 {}} {132520 15886 {}} {132524 25615 {}} {132528 59408 {}} {132532 37393 {}} {132536 51218 {}} {132540 34579 {}} {132544 3092 {}} {132548 45846 {}} {132552 59417 {}} {132556 5403 {}} {132560 84764 {}} {132564 80157 {}} {132568 89374 {}} {132572 8735 {}} {132576 24864 {}} {132580 47905 {}} {132584 9762 {}} {132588 60196 {}} {132592 13349 {}} {132596 43558 {}} {132600 14887 {}} {132604 327979 {}} {132608 393260 {}} {8240 5243040 {K, N}} {8244 6160 {NM, NO_PACKING, PSIZE}} {8248 1056773 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8252 6358534 {QC_OFF, LA_OFF, SC_OFF}} {65560 52428 SC_TABLE} {65564 12 {}} {98400 3074 LA_TABLE} {98404 3330 {}} {98408 3330 {}} {98412 3586 {}} {98416 3330 {}} {132624 65536 QC_TABLE} {132628 65536 {}} {132632 65536 {}} {132636 65536 {}} {132640 131328 {}} {132644 133889 {}} {132648 65536 {}} {132652 65536 {}} {132656 132868 {}} {132660 428293 {}} {132664 133634 {}} {132668 134147 {}} {132672 65536 {}} {132676 65536 {}} {132680 65536 {}} {132684 65536 {}} {132688 512 {}} {132692 257 {}} {132696 3586 {}} {132700 65536 {}} {132704 3588 {}} {132708 265733 {}} {132712 429062 {}} {132716 3843 {}} {132720 65536 {}} {132724 65536 {}} {132728 65536 {}} {132732 65536 {}} {132736 65536 {}} {132740 65536 {}} {132744 770 {}} {132748 515 {}} {132752 0 {}} {132756 2305 {}} {132760 264966 {}} {132764 427783 {}} {132768 1536 {}} {132772 65536 {}} {132776 65536 {}} {132780 65536 {}} {132784 772 {}} {132788 65536 {}} {132792 65536 {}} {132796 2563 {}} {132800 427016 {}} {132804 2049 {}} {132808 65536 {}} {132812 264711 {}} {132816 3072 {}} {132820 65536 {}} {132824 65536 {}} {132828 65536 {}} {132832 4 {}} {132836 3329 {}} {132840 65536 {}} {132844 65536 {}} {132848 263432 {}} {132852 426505 {}} {132856 2818 {}} {132860 65536 {}} {8256 18874848 {K, N}} {8260 10288 {NM, NO_PACKING, PSIZE}} {8264 1056772 {MAX_SCHEDULE, NO_FINAL_PARITY_CHECK, NORM_TYPE, NMQC, NLAYERS}} {8268 7342088 {QC_OFF, LA_OFF, SC_OFF}} {65568 52428 SC_TABLE} {98432 3075 LA_TABLE} {98436 3331 {}} {98440 3075 {}} {98444 3075 {}} {132864 135168 QC_TABLE} {132868 65536 {}} {132872 138242 {}} {132876 131329 {}} {132880 141316 {}} {132884 133379 {}} {132888 430086 {}} {132892 140805 {}} {132896 7168 {}} {132900 10753 {}} {132904 9218 {}} {132908 2819 {}} {132912 9988 {}} {132916 2309 {}} {132920 264198 {}} {132924 435719 {}} {132928 1280 {}} {132932 513 {}} {132936 4610 {}} {132940 4099 {}} {132944 6404 {}} {132948 12037 {}} {132952 430856 {}} {132956 262663 {}} {132960 4608 {}} {132964 4609 {}} {132968 10242 {}} {132972 4611 {}} {132976 4 {}} {132980 8709 {}} {132984 263944 {}} {132988 434185 {}} {20 1 FEC_CODE} {12 0 AXIS_WIDTH}} \
   CONFIG.Include_Encoder {false} \
   CONFIG.Include_PS_Example_Design {false} \
   CONFIG.Interrupts {false} \
   CONFIG.LDPC_Decode {true} \
   CONFIG.LDPC_Decode_Code_Definition {../../../../../../../../all_codes.txt} \
   CONFIG.LDPC_Decode_Max_Schedule {0} \
   CONFIG.LDPC_Decode_No_OPC {false} \
   CONFIG.LDPC_Decode_Overrides {false} \
   CONFIG.LDPC_Decode_Scale {12} \
   CONFIG.LDPC_Encode {false} \
   CONFIG.LD_PERCENT_LOAD {100} \
   CONFIG.Out_of_Order {false} \
   CONFIG.Parameter_Interface {Runtime-Configured} \
   CONFIG.Percentage_Loading {Automatic} \
   CONFIG.Physical_Utilization {100} \
   CONFIG.Standard {DOCSIS_3.1} \
   CONFIG.Turbo_Decode {false} \
   CONFIG.Turbo_Decode_Algorithm {MaxScale} \
   CONFIG.Turbo_Decode_Scale {12} \
 ] $sd_fec

  # Create instance: xlconcat_intr, and set properties
  set xlconcat_intr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_intr ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {5} \
 ] $xlconcat_intr

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_interconnect_ps_slave/M00_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_interconnect_ps_master/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_ctrl_M_AXI_MM2S [get_bd_intf_pins axi_dma_ctrl/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_ps_slave/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_ctrl_M_AXI_S2MM [get_bd_intf_pins axi_dma_ctrl/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_ps_slave/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_data_M_AXIS_MM2S [get_bd_intf_pins axi_dma_data/M_AXIS_MM2S] [get_bd_intf_pins axis_tx_fifo/S_AXIS]
  connect_bd_intf_net -intf_net axi_dma_data_M_AXI_MM2S [get_bd_intf_pins axi_dma_data/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_ps_slave/S02_AXI]
  connect_bd_intf_net -intf_net axi_dma_data_M_AXI_S2MM [get_bd_intf_pins axi_dma_data/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_ps_slave/S03_AXI]
  connect_bd_intf_net -intf_net axi_dma_dec_ctrl_M_AXIS_MM2S [get_bd_intf_pins axi_dma_ctrl/M_AXIS_MM2S] [get_bd_intf_pins sd_fec/S_AXIS_CTRL]
  connect_bd_intf_net -intf_net axi_interconnect_ps_master_M00_AXI [get_bd_intf_pins axi_dma_ctrl/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_ps_master/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_ps_master_M01_AXI [get_bd_intf_pins axi_dma_data/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_ps_master/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_ps_master_M02_AXI [get_bd_intf_pins axi_interconnect_ps_master/M02_AXI] [get_bd_intf_pins sd_fec/S_AXI]
  connect_bd_intf_net -intf_net axis_rx_fifo_M_AXIS [get_bd_intf_pins axi_dma_data/S_AXIS_S2MM] [get_bd_intf_pins axis_rx_fifo/M_AXIS]
  connect_bd_intf_net -intf_net axis_tx_fifo_M_AXIS [get_bd_intf_pins axis_tx_fifo/M_AXIS] [get_bd_intf_pins sd_fec/S_AXIS_DIN]
  connect_bd_intf_net -intf_net sd_fec_M_AXIS_DOUT [get_bd_intf_pins axis_rx_fifo/S_AXIS] [get_bd_intf_pins sd_fec/M_AXIS_DOUT]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins interconnect_reset] [get_bd_pins axi_interconnect_ps_master/ARESETN] [get_bd_pins axi_interconnect_ps_slave/ARESETN]
  connect_bd_net -net axi_dma_ctrl_mm2s_introut [get_bd_pins axi_dma_ctrl/mm2s_introut] [get_bd_pins xlconcat_intr/In0]
  connect_bd_net -net axi_dma_ctrl_s2mm_introut [get_bd_pins axi_dma_ctrl/s2mm_introut] [get_bd_pins xlconcat_intr/In1]
  connect_bd_net -net axi_dma_ctrl_s_axis_s2mm_tready [get_bd_pins axi_dma_ctrl/s_axis_s2mm_tready] [get_bd_pins sd_fec/m_axis_status_tready]
  connect_bd_net -net axi_dma_data_mm2s_introut [get_bd_pins axi_dma_data/mm2s_introut] [get_bd_pins xlconcat_intr/In2]
  connect_bd_net -net axi_dma_data_s2mm_introut [get_bd_pins axi_dma_data/s2mm_introut] [get_bd_pins xlconcat_intr/In3]
  connect_bd_net -net clk_wiz_0_clk_667M [get_bd_pins clk_667M] [get_bd_pins sd_fec/core_clk]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_50M] [get_bd_pins axi_dma_ctrl/m_axi_mm2s_aclk] [get_bd_pins axi_dma_ctrl/m_axi_s2mm_aclk] [get_bd_pins axi_dma_ctrl/s_axi_lite_aclk] [get_bd_pins axi_dma_data/m_axi_mm2s_aclk] [get_bd_pins axi_dma_data/m_axi_s2mm_aclk] [get_bd_pins axi_dma_data/s_axi_lite_aclk] [get_bd_pins axi_interconnect_ps_master/ACLK] [get_bd_pins axi_interconnect_ps_master/M00_ACLK] [get_bd_pins axi_interconnect_ps_master/M01_ACLK] [get_bd_pins axi_interconnect_ps_master/M02_ACLK] [get_bd_pins axi_interconnect_ps_master/S00_ACLK] [get_bd_pins axi_interconnect_ps_slave/ACLK] [get_bd_pins axi_interconnect_ps_slave/M00_ACLK] [get_bd_pins axi_interconnect_ps_slave/S00_ACLK] [get_bd_pins axi_interconnect_ps_slave/S01_ACLK] [get_bd_pins axi_interconnect_ps_slave/S02_ACLK] [get_bd_pins axi_interconnect_ps_slave/S03_ACLK] [get_bd_pins axis_rx_fifo/s_axis_aclk] [get_bd_pins axis_tx_fifo/s_axis_aclk] [get_bd_pins sd_fec/m_axis_dout_aclk] [get_bd_pins sd_fec/m_axis_status_aclk] [get_bd_pins sd_fec/s_axi_aclk] [get_bd_pins sd_fec/s_axis_ctrl_aclk] [get_bd_pins sd_fec/s_axis_din_aclk]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins peripheral_reset] [get_bd_pins axi_dma_ctrl/axi_resetn] [get_bd_pins axi_dma_data/axi_resetn] [get_bd_pins axi_interconnect_ps_master/M00_ARESETN] [get_bd_pins axi_interconnect_ps_master/M01_ARESETN] [get_bd_pins axi_interconnect_ps_master/M02_ARESETN] [get_bd_pins axi_interconnect_ps_master/S00_ARESETN] [get_bd_pins axi_interconnect_ps_slave/M00_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S00_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S01_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S02_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S03_ARESETN] [get_bd_pins axis_rx_fifo/s_axis_aresetn] [get_bd_pins axis_tx_fifo/s_axis_aresetn] [get_bd_pins sd_fec/reset_n]
  connect_bd_net -net sd_fec_interrupt [get_bd_pins sd_fec/interrupt] [get_bd_pins xlconcat_intr/In4]
  connect_bd_net -net sd_fec_m_axis_status_tdata [get_bd_pins axi_dma_ctrl/s_axis_s2mm_tdata] [get_bd_pins sd_fec/m_axis_status_tdata]
  connect_bd_net -net sd_fec_m_axis_status_tvalid [get_bd_pins axi_dma_ctrl/s_axis_s2mm_tlast] [get_bd_pins axi_dma_ctrl/s_axis_s2mm_tvalid] [get_bd_pins sd_fec/m_axis_status_tvalid]
  connect_bd_net -net xlconcat_intr_dout [get_bd_pins intr] [get_bd_pins xlconcat_intr/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set default_sysclk3_100mhz [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 default_sysclk3_100mhz ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $default_sysclk3_100mhz


  # Create ports

  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc_0 ]
  set_property -dict [ list \
   CONFIG.C_IRQ_CONNECTION {1} \
 ] $axi_intc_0

  # Create instance: axi_interconnect_ps_master, and set properties
  set axi_interconnect_ps_master [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_ps_master ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_interconnect_ps_master

  # Create instance: axi_interconnect_ps_slave, and set properties
  set axi_interconnect_ps_slave [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_ps_slave ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
 ] $axi_interconnect_ps_slave

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKOUT1_JITTER {69.097} \
   CONFIG.CLKOUT1_PHASE_ERROR {76.967} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {667} \
   CONFIG.CLKOUT2_JITTER {79.341} \
   CONFIG.CLKOUT2_PHASE_ERROR {76.967} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {300} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {108.951} \
   CONFIG.CLKOUT3_PHASE_ERROR {76.967} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {50} \
   CONFIG.CLKOUT3_USED {false} \
   CONFIG.CLK_IN1_BOARD_INTERFACE {default_sysclk3_100mhz} \
   CONFIG.CLK_OUT1_PORT {clk_667M} \
   CONFIG.CLK_OUT2_PORT {clk_500M} \
   CONFIG.CLK_OUT3_PORT {clk_50M} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {15.000} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {2.250} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {5} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {1} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.RESET_PORT {resetn} \
   CONFIG.RESET_TYPE {ACTIVE_LOW} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $clk_wiz_0

  # Create instance: ldpc_decoder
  create_hier_cell_ldpc_decoder [current_bd_instance .] ldpc_decoder

  # Create instance: ldpc_encoder
  create_hier_cell_ldpc_encoder [current_bd_instance .] ldpc_encoder

  # Create instance: rst_clk_wiz_50M, and set properties
  set rst_clk_wiz_50M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_50M ]

  # Create instance: rst_pl_clk0, and set properties
  set rst_pl_clk0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_pl_clk0 ]

  # Create instance: xlconcat_intr, and set properties
  set xlconcat_intr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_intr ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {2} \
 ] $xlconcat_intr

  # Create instance: zynq_ultra_ps_e_0, and set properties
  set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ultra_ps_e_0 ]
  set_property -dict [ list \
   CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
   CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
   CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
   CONFIG.PSU_DYNAMIC_DDR_CONFIG_EN {1} \
   CONFIG.PSU_MIO_0_DIRECTION {out} \
   CONFIG.PSU_MIO_0_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_0_POLARITY {Default} \
   CONFIG.PSU_MIO_10_DIRECTION {inout} \
   CONFIG.PSU_MIO_10_POLARITY {Default} \
   CONFIG.PSU_MIO_11_DIRECTION {inout} \
   CONFIG.PSU_MIO_11_POLARITY {Default} \
   CONFIG.PSU_MIO_12_DIRECTION {out} \
   CONFIG.PSU_MIO_12_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_12_POLARITY {Default} \
   CONFIG.PSU_MIO_13_DIRECTION {inout} \
   CONFIG.PSU_MIO_13_POLARITY {Default} \
   CONFIG.PSU_MIO_14_DIRECTION {inout} \
   CONFIG.PSU_MIO_14_POLARITY {Default} \
   CONFIG.PSU_MIO_15_DIRECTION {inout} \
   CONFIG.PSU_MIO_15_POLARITY {Default} \
   CONFIG.PSU_MIO_16_DIRECTION {inout} \
   CONFIG.PSU_MIO_16_POLARITY {Default} \
   CONFIG.PSU_MIO_17_DIRECTION {inout} \
   CONFIG.PSU_MIO_17_POLARITY {Default} \
   CONFIG.PSU_MIO_18_DIRECTION {in} \
   CONFIG.PSU_MIO_18_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_18_POLARITY {Default} \
   CONFIG.PSU_MIO_18_SLEW {fast} \
   CONFIG.PSU_MIO_19_DIRECTION {out} \
   CONFIG.PSU_MIO_19_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_19_POLARITY {Default} \
   CONFIG.PSU_MIO_1_DIRECTION {inout} \
   CONFIG.PSU_MIO_1_POLARITY {Default} \
   CONFIG.PSU_MIO_20_DIRECTION {inout} \
   CONFIG.PSU_MIO_20_POLARITY {Default} \
   CONFIG.PSU_MIO_21_DIRECTION {inout} \
   CONFIG.PSU_MIO_21_POLARITY {Default} \
   CONFIG.PSU_MIO_22_DIRECTION {inout} \
   CONFIG.PSU_MIO_22_POLARITY {Default} \
   CONFIG.PSU_MIO_23_DIRECTION {inout} \
   CONFIG.PSU_MIO_23_POLARITY {Default} \
   CONFIG.PSU_MIO_24_DIRECTION {inout} \
   CONFIG.PSU_MIO_24_POLARITY {Default} \
   CONFIG.PSU_MIO_25_DIRECTION {inout} \
   CONFIG.PSU_MIO_25_POLARITY {Default} \
   CONFIG.PSU_MIO_26_DIRECTION {inout} \
   CONFIG.PSU_MIO_26_POLARITY {Default} \
   CONFIG.PSU_MIO_27_DIRECTION {out} \
   CONFIG.PSU_MIO_27_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_27_POLARITY {Default} \
   CONFIG.PSU_MIO_28_DIRECTION {in} \
   CONFIG.PSU_MIO_28_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_28_POLARITY {Default} \
   CONFIG.PSU_MIO_28_SLEW {fast} \
   CONFIG.PSU_MIO_29_DIRECTION {out} \
   CONFIG.PSU_MIO_29_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_29_POLARITY {Default} \
   CONFIG.PSU_MIO_2_DIRECTION {inout} \
   CONFIG.PSU_MIO_2_POLARITY {Default} \
   CONFIG.PSU_MIO_30_DIRECTION {in} \
   CONFIG.PSU_MIO_30_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_30_POLARITY {Default} \
   CONFIG.PSU_MIO_30_SLEW {fast} \
   CONFIG.PSU_MIO_31_DIRECTION {inout} \
   CONFIG.PSU_MIO_31_POLARITY {Default} \
   CONFIG.PSU_MIO_32_DIRECTION {out} \
   CONFIG.PSU_MIO_32_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_32_POLARITY {Default} \
   CONFIG.PSU_MIO_33_DIRECTION {out} \
   CONFIG.PSU_MIO_33_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_33_POLARITY {Default} \
   CONFIG.PSU_MIO_34_DIRECTION {out} \
   CONFIG.PSU_MIO_34_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_34_POLARITY {Default} \
   CONFIG.PSU_MIO_35_DIRECTION {out} \
   CONFIG.PSU_MIO_35_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_35_POLARITY {Default} \
   CONFIG.PSU_MIO_36_DIRECTION {out} \
   CONFIG.PSU_MIO_36_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_36_POLARITY {Default} \
   CONFIG.PSU_MIO_37_DIRECTION {out} \
   CONFIG.PSU_MIO_37_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_37_POLARITY {Default} \
   CONFIG.PSU_MIO_38_DIRECTION {inout} \
   CONFIG.PSU_MIO_38_POLARITY {Default} \
   CONFIG.PSU_MIO_39_DIRECTION {inout} \
   CONFIG.PSU_MIO_39_POLARITY {Default} \
   CONFIG.PSU_MIO_3_DIRECTION {inout} \
   CONFIG.PSU_MIO_3_POLARITY {Default} \
   CONFIG.PSU_MIO_40_DIRECTION {inout} \
   CONFIG.PSU_MIO_40_POLARITY {Default} \
   CONFIG.PSU_MIO_41_DIRECTION {inout} \
   CONFIG.PSU_MIO_41_POLARITY {Default} \
   CONFIG.PSU_MIO_42_DIRECTION {inout} \
   CONFIG.PSU_MIO_42_POLARITY {Default} \
   CONFIG.PSU_MIO_43_DIRECTION {inout} \
   CONFIG.PSU_MIO_43_POLARITY {Default} \
   CONFIG.PSU_MIO_44_DIRECTION {inout} \
   CONFIG.PSU_MIO_44_POLARITY {Default} \
   CONFIG.PSU_MIO_45_DIRECTION {in} \
   CONFIG.PSU_MIO_45_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_45_POLARITY {Default} \
   CONFIG.PSU_MIO_45_SLEW {fast} \
   CONFIG.PSU_MIO_46_DIRECTION {inout} \
   CONFIG.PSU_MIO_46_POLARITY {Default} \
   CONFIG.PSU_MIO_47_DIRECTION {inout} \
   CONFIG.PSU_MIO_47_POLARITY {Default} \
   CONFIG.PSU_MIO_48_DIRECTION {inout} \
   CONFIG.PSU_MIO_48_POLARITY {Default} \
   CONFIG.PSU_MIO_49_DIRECTION {inout} \
   CONFIG.PSU_MIO_49_POLARITY {Default} \
   CONFIG.PSU_MIO_4_DIRECTION {inout} \
   CONFIG.PSU_MIO_4_POLARITY {Default} \
   CONFIG.PSU_MIO_50_DIRECTION {inout} \
   CONFIG.PSU_MIO_50_POLARITY {Default} \
   CONFIG.PSU_MIO_51_DIRECTION {out} \
   CONFIG.PSU_MIO_51_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_51_POLARITY {Default} \
   CONFIG.PSU_MIO_52_DIRECTION {in} \
   CONFIG.PSU_MIO_52_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_52_POLARITY {Default} \
   CONFIG.PSU_MIO_52_SLEW {fast} \
   CONFIG.PSU_MIO_53_DIRECTION {in} \
   CONFIG.PSU_MIO_53_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_53_POLARITY {Default} \
   CONFIG.PSU_MIO_53_SLEW {fast} \
   CONFIG.PSU_MIO_54_DIRECTION {inout} \
   CONFIG.PSU_MIO_54_POLARITY {Default} \
   CONFIG.PSU_MIO_55_DIRECTION {in} \
   CONFIG.PSU_MIO_55_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_55_POLARITY {Default} \
   CONFIG.PSU_MIO_55_SLEW {fast} \
   CONFIG.PSU_MIO_56_DIRECTION {inout} \
   CONFIG.PSU_MIO_56_POLARITY {Default} \
   CONFIG.PSU_MIO_57_DIRECTION {inout} \
   CONFIG.PSU_MIO_57_POLARITY {Default} \
   CONFIG.PSU_MIO_58_DIRECTION {out} \
   CONFIG.PSU_MIO_58_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_58_POLARITY {Default} \
   CONFIG.PSU_MIO_59_DIRECTION {inout} \
   CONFIG.PSU_MIO_59_POLARITY {Default} \
   CONFIG.PSU_MIO_5_DIRECTION {out} \
   CONFIG.PSU_MIO_5_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_5_POLARITY {Default} \
   CONFIG.PSU_MIO_60_DIRECTION {inout} \
   CONFIG.PSU_MIO_60_POLARITY {Default} \
   CONFIG.PSU_MIO_61_DIRECTION {inout} \
   CONFIG.PSU_MIO_61_POLARITY {Default} \
   CONFIG.PSU_MIO_62_DIRECTION {inout} \
   CONFIG.PSU_MIO_62_POLARITY {Default} \
   CONFIG.PSU_MIO_63_DIRECTION {inout} \
   CONFIG.PSU_MIO_63_POLARITY {Default} \
   CONFIG.PSU_MIO_64_DIRECTION {out} \
   CONFIG.PSU_MIO_64_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_64_POLARITY {Default} \
   CONFIG.PSU_MIO_65_DIRECTION {out} \
   CONFIG.PSU_MIO_65_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_65_POLARITY {Default} \
   CONFIG.PSU_MIO_66_DIRECTION {out} \
   CONFIG.PSU_MIO_66_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_66_POLARITY {Default} \
   CONFIG.PSU_MIO_67_DIRECTION {out} \
   CONFIG.PSU_MIO_67_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_67_POLARITY {Default} \
   CONFIG.PSU_MIO_68_DIRECTION {out} \
   CONFIG.PSU_MIO_68_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_68_POLARITY {Default} \
   CONFIG.PSU_MIO_69_DIRECTION {out} \
   CONFIG.PSU_MIO_69_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_69_POLARITY {Default} \
   CONFIG.PSU_MIO_6_DIRECTION {out} \
   CONFIG.PSU_MIO_6_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_6_POLARITY {Default} \
   CONFIG.PSU_MIO_70_DIRECTION {in} \
   CONFIG.PSU_MIO_70_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_70_POLARITY {Default} \
   CONFIG.PSU_MIO_70_SLEW {fast} \
   CONFIG.PSU_MIO_71_DIRECTION {in} \
   CONFIG.PSU_MIO_71_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_71_POLARITY {Default} \
   CONFIG.PSU_MIO_71_SLEW {fast} \
   CONFIG.PSU_MIO_72_DIRECTION {in} \
   CONFIG.PSU_MIO_72_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_72_POLARITY {Default} \
   CONFIG.PSU_MIO_72_SLEW {fast} \
   CONFIG.PSU_MIO_73_DIRECTION {in} \
   CONFIG.PSU_MIO_73_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_73_POLARITY {Default} \
   CONFIG.PSU_MIO_73_SLEW {fast} \
   CONFIG.PSU_MIO_74_DIRECTION {in} \
   CONFIG.PSU_MIO_74_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_74_POLARITY {Default} \
   CONFIG.PSU_MIO_74_SLEW {fast} \
   CONFIG.PSU_MIO_75_DIRECTION {in} \
   CONFIG.PSU_MIO_75_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_75_POLARITY {Default} \
   CONFIG.PSU_MIO_75_SLEW {fast} \
   CONFIG.PSU_MIO_76_DIRECTION {out} \
   CONFIG.PSU_MIO_76_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_76_POLARITY {Default} \
   CONFIG.PSU_MIO_77_DIRECTION {inout} \
   CONFIG.PSU_MIO_77_POLARITY {Default} \
   CONFIG.PSU_MIO_7_DIRECTION {out} \
   CONFIG.PSU_MIO_7_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_7_POLARITY {Default} \
   CONFIG.PSU_MIO_8_DIRECTION {inout} \
   CONFIG.PSU_MIO_8_POLARITY {Default} \
   CONFIG.PSU_MIO_9_DIRECTION {inout} \
   CONFIG.PSU_MIO_9_POLARITY {Default} \
   CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Feedback Clk#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO0 MIO#I2C 0#I2C 0#I2C 1#I2C 1#UART 0#UART 0#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO1 MIO#DPAUX#DPAUX#DPAUX#DPAUX#GPIO1 MIO#PMU GPO 0#PMU GPO 1#PMU GPO 2#PMU GPO 3#PMU GPO 4#PMU GPO 5#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#GPIO1 MIO#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#MDIO 3#MDIO 3} \
   CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out#clk_for_lpbk#n_ss_out_upper#mo_upper[0]#mo_upper[1]#mo_upper[2]#mo_upper[3]#sclk_out_upper#gpio0[13]#scl_out#sda_out#scl_out#sda_out#rxd#txd#gpio0[20]#gpio0[21]#gpio0[22]#gpio0[23]#gpio0[24]#gpio0[25]#gpio1[26]#dp_aux_data_out#dp_hot_plug_detect#dp_aux_data_oe#dp_aux_data_in#gpio1[31]#gpo[0]#gpo[1]#gpo[2]#gpo[3]#gpo[4]#gpo[5]#gpio1[38]#sdio1_data_out[4]#sdio1_data_out[5]#sdio1_data_out[6]#sdio1_data_out[7]#gpio1[43]#gpio1[44]#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out} \
   CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {8} \
   CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
   CONFIG.PSU__ACT_DDR_FREQ_MHZ {1066.656006} \
   CONFIG.PSU__CAN1__GRP_CLK__ENABLE {0} \
   CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1199.988037} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1200} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FBDIV {72} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__APLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__APLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {533.328003} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FBDIV {64} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__DPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__DPLL_TO_LPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {24.999750} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_AUDIO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.785446} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR0 {14} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {299.997009} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {533.328003} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__VPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__VPLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {49.999500} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR0 {30} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.984985} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {124.998749} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__IOPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__IOPLL_TO_FPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.498123} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {299.997009} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {300} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {124.998749} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FBDIV {45} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__RPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__RPLL_TO_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {187.498123} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.999800} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR0 {25} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR1 {3} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
   CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {1} \
   CONFIG.PSU__DDRC__ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__BANK_ADDR_COUNT {2} \
   CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
   CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
   CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
   CONFIG.PSU__DDRC__CL {15} \
   CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
   CONFIG.PSU__DDRC__COL_ADDR_COUNT {10} \
   CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
   CONFIG.PSU__DDRC__CWL {14} \
   CONFIG.PSU__DDRC__DDR3L_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
   CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
   CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
   CONFIG.PSU__DDRC__DEEP_PWR_DOWN_EN {0} \
   CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
   CONFIG.PSU__DDRC__DIMM_ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
   CONFIG.PSU__DDRC__DQMAP_0_3 {0} \
   CONFIG.PSU__DDRC__DQMAP_12_15 {0} \
   CONFIG.PSU__DDRC__DQMAP_16_19 {0} \
   CONFIG.PSU__DDRC__DQMAP_20_23 {0} \
   CONFIG.PSU__DDRC__DQMAP_24_27 {0} \
   CONFIG.PSU__DDRC__DQMAP_28_31 {0} \
   CONFIG.PSU__DDRC__DQMAP_32_35 {0} \
   CONFIG.PSU__DDRC__DQMAP_36_39 {0} \
   CONFIG.PSU__DDRC__DQMAP_40_43 {0} \
   CONFIG.PSU__DDRC__DQMAP_44_47 {0} \
   CONFIG.PSU__DDRC__DQMAP_48_51 {0} \
   CONFIG.PSU__DDRC__DQMAP_4_7 {0} \
   CONFIG.PSU__DDRC__DQMAP_52_55 {0} \
   CONFIG.PSU__DDRC__DQMAP_56_59 {0} \
   CONFIG.PSU__DDRC__DQMAP_60_63 {0} \
   CONFIG.PSU__DDRC__DQMAP_64_67 {0} \
   CONFIG.PSU__DDRC__DQMAP_68_71 {0} \
   CONFIG.PSU__DDRC__DQMAP_8_11 {0} \
   CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
   CONFIG.PSU__DDRC__ECC {Disabled} \
   CONFIG.PSU__DDRC__ENABLE_LP4_HAS_ECC_COMP {0} \
   CONFIG.PSU__DDRC__ENABLE_LP4_SLOWBOOT {0} \
   CONFIG.PSU__DDRC__FGRM {1X} \
   CONFIG.PSU__DDRC__LPDDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LPDDR4_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LP_ASR {manual normal} \
   CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
   CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
   CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
   CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
   CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
   CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
   CONFIG.PSU__DDRC__SB_TARGET {15-15-15} \
   CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
   CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
   CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
   CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
   CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
   CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
   CONFIG.PSU__DDRC__T_FAW {30.0} \
   CONFIG.PSU__DDRC__T_RAS_MIN {33} \
   CONFIG.PSU__DDRC__T_RC {47.06} \
   CONFIG.PSU__DDRC__T_RCD {15} \
   CONFIG.PSU__DDRC__T_RP {15} \
   CONFIG.PSU__DDRC__VENDOR_PART {OTHERS} \
   CONFIG.PSU__DDRC__VREF {1} \
   CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
   CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.500} \
   CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane1} \
   CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE1__IO {GT Lane0} \
   CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DLL__ISUSED {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
   CONFIG.PSU__DP__LANE_SEL {Dual Lower} \
   CONFIG.PSU__DP__REF_CLK_FREQ {27} \
   CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk1} \
   CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
   CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
   CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
   CONFIG.PSU__ENET3__PTP__ENABLE {0} \
   CONFIG.PSU__ENET3__TSU__ENABLE {0} \
   CONFIG.PSU__FPDMASTERS_COHERENCY {0} \
   CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__FPD_SLCR__WDT1__FREQMHZ {99.999001} \
   CONFIG.PSU__FPD_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__FPGA_PL0_ENABLE {1} \
   CONFIG.PSU__GEM3_COHERENCY {0} \
   CONFIG.PSU__GEM3_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM__TSU__ENABLE {0} \
   CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
   CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
   CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GT__LINK_SPEED {HBR} \
   CONFIG.PSU__GT__PRE_EMPH_LVL_4 {0} \
   CONFIG.PSU__GT__VLT_SWNG_LVL_4 {0} \
   CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
   CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC0__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__IOU_SLCR__WDT0__FREQMHZ {99.999001} \
   CONFIG.PSU__IOU_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__FREQMHZ {100.000000} \
   CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP1__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP2__DATA_WIDTH {32} \
   CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
   CONFIG.PSU__PL_CLK0_BUF {TRUE} \
   CONFIG.PSU__PMU_COHERENCY {0} \
   CONFIG.PSU__PMU__AIBACK__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPI__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPO__ENABLE {0} \
   CONFIG.PSU__PMU__GPI0__ENABLE {0} \
   CONFIG.PSU__PMU__GPI1__ENABLE {0} \
   CONFIG.PSU__PMU__GPI2__ENABLE {0} \
   CONFIG.PSU__PMU__GPI3__ENABLE {0} \
   CONFIG.PSU__PMU__GPI4__ENABLE {0} \
   CONFIG.PSU__PMU__GPI5__ENABLE {0} \
   CONFIG.PSU__PMU__GPO0__ENABLE {1} \
   CONFIG.PSU__PMU__GPO0__IO {MIO 32} \
   CONFIG.PSU__PMU__GPO1__ENABLE {1} \
   CONFIG.PSU__PMU__GPO1__IO {MIO 33} \
   CONFIG.PSU__PMU__GPO2__ENABLE {1} \
   CONFIG.PSU__PMU__GPO2__IO {MIO 34} \
   CONFIG.PSU__PMU__GPO2__POLARITY {low} \
   CONFIG.PSU__PMU__GPO3__ENABLE {1} \
   CONFIG.PSU__PMU__GPO3__IO {MIO 35} \
   CONFIG.PSU__PMU__GPO3__POLARITY {low} \
   CONFIG.PSU__PMU__GPO4__ENABLE {1} \
   CONFIG.PSU__PMU__GPO4__IO {MIO 36} \
   CONFIG.PSU__PMU__GPO4__POLARITY {low} \
   CONFIG.PSU__PMU__GPO5__ENABLE {1} \
   CONFIG.PSU__PMU__GPO5__IO {MIO 37} \
   CONFIG.PSU__PMU__GPO5__POLARITY {low} \
   CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__PMU__PLERROR__ENABLE {0} \
   CONFIG.PSU__PRESET_APPLIED {1} \
   CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;0|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;0|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;1|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;0|SATA1:NonSecure;1|SATA0:NonSecure;1|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;1|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1} \
   CONFIG.PSU__PROTECTION__SLAVES { \
     LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;1|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;0|FPD;SATA;FD0C0000;FD0CFFFF;1|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;0|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display Port;FD4A0000;FD4AFFFF;1|FPD;DPDMA;FD4C0000;FD4CFFFF;1|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1 \
   } \
   CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333} \
   CONFIG.PSU__QSPI_COHERENCY {0} \
   CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
   CONFIG.PSU__QSPI__GRP_FBCLK__IO {MIO 6} \
   CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
   CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \
   CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
   CONFIG.PSU__SATA__LANE0__ENABLE {0} \
   CONFIG.PSU__SATA__LANE1__ENABLE {1} \
   CONFIG.PSU__SATA__LANE1__IO {GT Lane3} \
   CONFIG.PSU__SATA__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SATA__REF_CLK_FREQ {125} \
   CONFIG.PSU__SATA__REF_CLK_SEL {Ref Clk3} \
   CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
   CONFIG.PSU__SD1_COHERENCY {0} \
   CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
   CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
   CONFIG.PSU__SD1__GRP_POW__ENABLE {0} \
   CONFIG.PSU__SD1__GRP_WP__ENABLE {0} \
   CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
   CONFIG.PSU__SD1__RESET__ENABLE {0} \
   CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
   CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
   CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
   CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
   CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__UART0__BAUD_RATE {115200} \
   CONFIG.PSU__UART0__MODEM__ENABLE {0} \
   CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \
   CONFIG.PSU__UART1__BAUD_RATE {115200} \
   CONFIG.PSU__UART1__MODEM__ENABLE {0} \
   CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART1__PERIPHERAL__IO {EMIO} \
   CONFIG.PSU__USB0_COHERENCY {0} \
   CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
   CONFIG.PSU__USB0__REF_CLK_FREQ {26} \
   CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
   CONFIG.PSU__USB0__RESET__ENABLE {0} \
   CONFIG.PSU__USB1__RESET__ENABLE {0} \
   CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
   CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
   CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
   CONFIG.PSU__USE__IRQ0 {1} \
   CONFIG.PSU__USE__M_AXI_GP0 {1} \
   CONFIG.PSU__USE__M_AXI_GP1 {0} \
   CONFIG.PSU__USE__M_AXI_GP2 {0} \
   CONFIG.PSU__USE__S_AXI_GP2 {1} \
   CONFIG.SUBPRESET1 {Custom} \
 ] $zynq_ultra_ps_e_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_interconnect_ps_master/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_interconnect_ps_slave/S00_AXI] [get_bd_intf_pins ldpc_encoder/M00_AXI]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins axi_interconnect_ps_slave/S01_AXI] [get_bd_intf_pins ldpc_decoder/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_interconnect_ps_slave/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_ps_master_M00_AXI [get_bd_intf_pins axi_interconnect_ps_master/M00_AXI] [get_bd_intf_pins ldpc_encoder/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_ps_master_M01_AXI [get_bd_intf_pins axi_interconnect_ps_master/M01_AXI] [get_bd_intf_pins ldpc_decoder/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_ps_master_M02_AXI [get_bd_intf_pins axi_intc_0/s_axi] [get_bd_intf_pins axi_interconnect_ps_master/M02_AXI]
  connect_bd_intf_net -intf_net default_sysclk3_100mhz_1 [get_bd_intf_ports default_sysclk3_100mhz] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]

  # Create port connections
  connect_bd_net -net M00_ACLK_1 [get_bd_pins axi_interconnect_ps_master/ACLK] [get_bd_pins axi_interconnect_ps_master/S00_ACLK] [get_bd_pins axi_interconnect_ps_slave/ACLK] [get_bd_pins axi_interconnect_ps_slave/M00_ACLK] [get_bd_pins rst_pl_clk0/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins zynq_ultra_ps_e_0/saxihp0_fpd_aclk]
  connect_bd_net -net axi_intc_0_irq [get_bd_pins axi_intc_0/irq] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq0]
  connect_bd_net -net clk_wiz_0_clk_667M [get_bd_pins clk_wiz_0/clk_667M] [get_bd_pins ldpc_decoder/clk_667M] [get_bd_pins ldpc_encoder/clk_667M]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins axi_intc_0/s_axi_aclk] [get_bd_pins axi_interconnect_ps_master/M00_ACLK] [get_bd_pins axi_interconnect_ps_master/M01_ACLK] [get_bd_pins axi_interconnect_ps_master/M02_ACLK] [get_bd_pins axi_interconnect_ps_slave/S00_ACLK] [get_bd_pins axi_interconnect_ps_slave/S01_ACLK] [get_bd_pins clk_wiz_0/clk_500M] [get_bd_pins ldpc_decoder/clk_50M] [get_bd_pins ldpc_encoder/clk_50M] [get_bd_pins rst_clk_wiz_50M/slowest_sync_clk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins rst_clk_wiz_50M/dcm_locked]
  connect_bd_net -net interconnect_reset_1 [get_bd_pins ldpc_decoder/interconnect_reset] [get_bd_pins ldpc_encoder/interconnect_reset] [get_bd_pins rst_clk_wiz_50M/interconnect_aresetn]
  connect_bd_net -net ldpc_decoder_dout [get_bd_pins ldpc_decoder/intr] [get_bd_pins xlconcat_intr/In1]
  connect_bd_net -net ldpc_encoder_dout [get_bd_pins ldpc_encoder/intr] [get_bd_pins xlconcat_intr/In0]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins axi_intc_0/s_axi_aresetn] [get_bd_pins axi_interconnect_ps_master/M00_ARESETN] [get_bd_pins axi_interconnect_ps_master/M01_ARESETN] [get_bd_pins axi_interconnect_ps_master/M02_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S00_ARESETN] [get_bd_pins axi_interconnect_ps_slave/S01_ARESETN] [get_bd_pins ldpc_decoder/peripheral_reset] [get_bd_pins ldpc_encoder/peripheral_reset] [get_bd_pins rst_clk_wiz_50M/peripheral_aresetn]
  connect_bd_net -net rst_pl_clk0_interconnect_aresetn [get_bd_pins axi_interconnect_ps_master/ARESETN] [get_bd_pins axi_interconnect_ps_slave/ARESETN] [get_bd_pins rst_pl_clk0/interconnect_aresetn]
  connect_bd_net -net rst_pl_clk0_peripheral_aresetn [get_bd_pins axi_interconnect_ps_master/S00_ARESETN] [get_bd_pins axi_interconnect_ps_slave/M00_ARESETN] [get_bd_pins rst_pl_clk0/peripheral_aresetn]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axi_intc_0/intr] [get_bd_pins xlconcat_intr/dout]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_resetn0 [get_bd_pins clk_wiz_0/resetn] [get_bd_pins rst_clk_wiz_50M/ext_reset_in] [get_bd_pins rst_pl_clk0/ext_reset_in] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]

  # Create address segments
  assign_bd_address -offset 0xA0040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs ldpc_encoder/axi_dma_ctrl/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0050000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs ldpc_decoder/axi_dma_ctrl/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs ldpc_encoder/axi_dma_data/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs ldpc_decoder/axi_dma_data/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_intc_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA0080000 -range 0x00040000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs ldpc_decoder/sd_fec/S_AXI/PARAMS] -force
  assign_bd_address -offset 0xA00C0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs ldpc_encoder/sd_fec/S_AXI/PARAMS] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ldpc_decoder/axi_dma_ctrl/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ldpc_decoder/axi_dma_ctrl/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces ldpc_decoder/axi_dma_ctrl/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces ldpc_decoder/axi_dma_ctrl/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ldpc_decoder/axi_dma_data/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ldpc_decoder/axi_dma_data/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces ldpc_decoder/axi_dma_data/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces ldpc_decoder/axi_dma_data/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ldpc_encoder/axi_dma_ctrl/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ldpc_encoder/axi_dma_ctrl/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces ldpc_encoder/axi_dma_ctrl/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces ldpc_encoder/axi_dma_ctrl/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ldpc_encoder/axi_dma_data/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ldpc_encoder/axi_dma_data/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces ldpc_encoder/axi_dma_data/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces ldpc_encoder/axi_dma_data/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces ldpc_decoder/axi_dma_data/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces ldpc_encoder/axi_dma_data/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM]


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


