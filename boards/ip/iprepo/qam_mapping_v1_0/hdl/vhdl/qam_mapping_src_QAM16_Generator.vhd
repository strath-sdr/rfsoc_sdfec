-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\fec_ber_hw\qam_mapping_src_QAM16_Generator.vhd
-- Created: 2022-10-06 15:06:34
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: qam_mapping_src_QAM16_Generator
-- Source Path: fec_ber_hw/QAM Mapping/QAM16 Generator
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY qam_mapping_src_QAM16_Generator IS
  PORT( symbol                            :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        Out1_re                           :   OUT   std_logic_vector(3 DOWNTO 0);  -- sfix4
        Out1_im                           :   OUT   std_logic_vector(3 DOWNTO 0)  -- sfix4
        );
END qam_mapping_src_QAM16_Generator;


ARCHITECTURE rtl OF qam_mapping_src_QAM16_Generator IS

  -- Signals
  SIGNAL symbol_unsigned                  : unsigned(3 DOWNTO 0);  -- ufix4
  SIGNAL Bit_Slice2_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Constant4_out1                   : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Constant3_out1                   : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Constant1_out1                   : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Constant2_out1                   : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Multiport_Switch_out1            : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Bit_Slice1_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Multiport_Switch1_out1           : signed(2 DOWNTO 0);  -- sfix3
  SIGNAL Data_Type_Conversion_out1_re     : signed(3 DOWNTO 0);  -- sfix4
  SIGNAL Data_Type_Conversion_out1_im     : signed(3 DOWNTO 0);  -- sfix4

BEGIN
  symbol_unsigned <= unsigned(symbol);

  Bit_Slice2_out1 <= symbol_unsigned(3 DOWNTO 2);

  Constant4_out1 <= to_signed(-16#3#, 3);

  Constant3_out1 <= to_signed(-16#1#, 3);

  Constant1_out1 <= to_signed(16#3#, 3);

  Constant2_out1 <= to_signed(16#1#, 3);

  
  Multiport_Switch_out1 <= Constant4_out1 WHEN Bit_Slice2_out1 = to_unsigned(16#0#, 2) ELSE
      Constant3_out1 WHEN Bit_Slice2_out1 = to_unsigned(16#1#, 2) ELSE
      Constant1_out1 WHEN Bit_Slice2_out1 = to_unsigned(16#2#, 2) ELSE
      Constant2_out1;

  Bit_Slice1_out1 <= symbol_unsigned(1 DOWNTO 0);

  
  Multiport_Switch1_out1 <= Constant1_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#0#, 2) ELSE
      Constant2_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#1#, 2) ELSE
      Constant4_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#2#, 2) ELSE
      Constant3_out1;

  Data_Type_Conversion_out1_re <= resize(Multiport_Switch_out1, 4);
  Data_Type_Conversion_out1_im <= resize(Multiport_Switch1_out1, 4);

  Out1_re <= std_logic_vector(Data_Type_Conversion_out1_re);

  Out1_im <= std_logic_vector(Data_Type_Conversion_out1_im);

END rtl;

