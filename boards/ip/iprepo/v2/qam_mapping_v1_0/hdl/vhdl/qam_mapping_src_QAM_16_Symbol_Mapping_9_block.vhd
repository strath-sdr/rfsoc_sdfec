-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\qam_mapping_src_QAM_16_Symbol_Mapping_9_block.vhd
-- Created: 2022-10-27 12:38:09
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: qam_mapping_src_QAM_16_Symbol_Mapping_9_block
-- Source Path: fec_ber_hw_V2/QAM Mapping/QAM Mapping/N-Width QAM-16 Symbol Mapping Real/QAM-16 Symbol Mapping 9
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY qam_mapping_src_QAM_16_Symbol_Mapping_9_block IS
  PORT( bits                              :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        I                                 :   OUT   std_logic_vector(2 DOWNTO 0)  -- sfix3
        );
END qam_mapping_src_QAM_16_Symbol_Mapping_9_block;


ARCHITECTURE rtl OF qam_mapping_src_QAM_16_Symbol_Mapping_9_block IS

  -- Signals
  SIGNAL bits_unsigned                    : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL Bit_Slice1_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Constant4_out1                   : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Constant3_out1                   : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Constant1_out1                   : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Constant2_out1                   : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Multiport_Switch_out1            : signed(2 DOWNTO 0);  -- sfix3

BEGIN
  -- bits are read from msb

  bits_unsigned <= unsigned(bits);

  Bit_Slice1_out1 <= bits_unsigned(25 DOWNTO 24);

  Constant4_out1 <= to_signed(-16#3#, 3);

  Constant3_out1 <= to_signed(16#3#, 3);

  Constant1_out1 <= to_signed(-16#1#, 3);

  Constant2_out1 <= to_signed(16#1#, 3);

  
  Multiport_Switch_out1 <= Constant4_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#0#, 2) ELSE
      Constant3_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#1#, 2) ELSE
      Constant1_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#2#, 2) ELSE
      Constant2_out1;

  I <= std_logic_vector(Multiport_Switch_out1);

END rtl;

