-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example\qam_mapping_src_QAM16_Generator.vhd
-- Created: 2023-01-16 15:11:30
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: qam_mapping_src_QAM16_Generator
-- Source Path: book_example/QAM Mapping/QAM16 Generator
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY qam_mapping_src_QAM16_Generator IS
  PORT( bits                              :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        symbol                            :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
        );
END qam_mapping_src_QAM16_Generator;


ARCHITECTURE rtl OF qam_mapping_src_QAM16_Generator IS

  -- Signals
  SIGNAL bits_unsigned                    : unsigned(3 DOWNTO 0);  -- ufix4
  SIGNAL Bit_Slice1_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Constant1_out1                   : signed(3 DOWNTO 0);  -- sfix4
  SIGNAL Constant2_out1                   : signed(3 DOWNTO 0);  -- sfix4
  SIGNAL Constant4_out1                   : signed(3 DOWNTO 0);  -- sfix4
  SIGNAL Constant3_out1                   : signed(3 DOWNTO 0);  -- sfix4
  SIGNAL Q                                : signed(3 DOWNTO 0);  -- sfix4
  SIGNAL Bit_Slice2_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL I                                : signed(3 DOWNTO 0);  -- sfix4
  SIGNAL Bit_Concat1_out1                 : unsigned(7 DOWNTO 0);  -- uint8

BEGIN
  bits_unsigned <= unsigned(bits);

  Bit_Slice1_out1 <= bits_unsigned(1 DOWNTO 0);

  Constant1_out1 <= to_signed(16#3#, 4);

  Constant2_out1 <= to_signed(16#1#, 4);

  Constant4_out1 <= to_signed(-16#3#, 4);

  Constant3_out1 <= to_signed(-16#1#, 4);

  
  Q <= Constant1_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#0#, 2) ELSE
      Constant2_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#1#, 2) ELSE
      Constant4_out1 WHEN Bit_Slice1_out1 = to_unsigned(16#2#, 2) ELSE
      Constant3_out1;

  Bit_Slice2_out1 <= bits_unsigned(3 DOWNTO 2);

  
  I <= Constant4_out1 WHEN Bit_Slice2_out1 = to_unsigned(16#0#, 2) ELSE
      Constant3_out1 WHEN Bit_Slice2_out1 = to_unsigned(16#1#, 2) ELSE
      Constant1_out1 WHEN Bit_Slice2_out1 = to_unsigned(16#2#, 2) ELSE
      Constant2_out1;

  Bit_Concat1_out1 <= unsigned(Q) & unsigned(I);

  symbol <= std_logic_vector(Bit_Concat1_out1);

END rtl;

