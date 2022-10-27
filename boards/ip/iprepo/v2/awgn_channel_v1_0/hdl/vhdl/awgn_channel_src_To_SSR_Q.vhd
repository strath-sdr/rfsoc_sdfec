-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\awgn_channel_src_To_SSR_Q.vhd
-- Created: 2022-10-27 12:50:15
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: awgn_channel_src_To_SSR_Q
-- Source Path: fec_ber_hw_V2/AWGN Channel/To SSR Q
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.awgn_channel_src_AWGN_Channel_pkg.ALL;

ENTITY awgn_channel_src_To_SSR_Q IS
  PORT( data_wide                         :   IN    std_logic_vector(47 DOWNTO 0);  -- ufix48
        data_ssr                          :   OUT   vector_of_std_logic_vector3(0 TO 15)  -- ufix3 [16]
        );
END awgn_channel_src_To_SSR_Q;


ARCHITECTURE rtl OF awgn_channel_src_To_SSR_Q IS

  -- Signals
  SIGNAL data_wide_unsigned               : unsigned(47 DOWNTO 0);  -- ufix48
  SIGNAL Bit_Slice_0_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_1_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_2_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_3_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_4_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_5_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_6_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_7_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_8_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_9_out1                 : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_10_out1                : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_11_out1                : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_12_out1                : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_13_out1                : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_14_out1                : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Bit_Slice_15_out1                : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL mux_out1                         : vector_of_unsigned3(0 TO 15);  -- ufix3 [16]

BEGIN
  data_wide_unsigned <= unsigned(data_wide);

  Bit_Slice_0_out1 <= data_wide_unsigned(2 DOWNTO 0);

  Bit_Slice_1_out1 <= data_wide_unsigned(5 DOWNTO 3);

  Bit_Slice_2_out1 <= data_wide_unsigned(8 DOWNTO 6);

  Bit_Slice_3_out1 <= data_wide_unsigned(11 DOWNTO 9);

  Bit_Slice_4_out1 <= data_wide_unsigned(14 DOWNTO 12);

  Bit_Slice_5_out1 <= data_wide_unsigned(17 DOWNTO 15);

  Bit_Slice_6_out1 <= data_wide_unsigned(20 DOWNTO 18);

  Bit_Slice_7_out1 <= data_wide_unsigned(23 DOWNTO 21);

  Bit_Slice_8_out1 <= data_wide_unsigned(26 DOWNTO 24);

  Bit_Slice_9_out1 <= data_wide_unsigned(29 DOWNTO 27);

  Bit_Slice_10_out1 <= data_wide_unsigned(32 DOWNTO 30);

  Bit_Slice_11_out1 <= data_wide_unsigned(35 DOWNTO 33);

  Bit_Slice_12_out1 <= data_wide_unsigned(38 DOWNTO 36);

  Bit_Slice_13_out1 <= data_wide_unsigned(41 DOWNTO 39);

  Bit_Slice_14_out1 <= data_wide_unsigned(44 DOWNTO 42);

  Bit_Slice_15_out1 <= data_wide_unsigned(47 DOWNTO 45);

  mux_out1(0) <= Bit_Slice_0_out1;
  mux_out1(1) <= Bit_Slice_1_out1;
  mux_out1(2) <= Bit_Slice_2_out1;
  mux_out1(3) <= Bit_Slice_3_out1;
  mux_out1(4) <= Bit_Slice_4_out1;
  mux_out1(5) <= Bit_Slice_5_out1;
  mux_out1(6) <= Bit_Slice_6_out1;
  mux_out1(7) <= Bit_Slice_7_out1;
  mux_out1(8) <= Bit_Slice_8_out1;
  mux_out1(9) <= Bit_Slice_9_out1;
  mux_out1(10) <= Bit_Slice_10_out1;
  mux_out1(11) <= Bit_Slice_11_out1;
  mux_out1(12) <= Bit_Slice_12_out1;
  mux_out1(13) <= Bit_Slice_13_out1;
  mux_out1(14) <= Bit_Slice_14_out1;
  mux_out1(15) <= Bit_Slice_15_out1;

  outputgen: FOR k IN 0 TO 15 GENERATE
    data_ssr(k) <= std_logic_vector(mux_out1(k));
  END GENERATE;

END rtl;

