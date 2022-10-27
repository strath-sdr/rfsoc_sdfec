-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\awgn_channel_src_From_SSR_Q.vhd
-- Created: 2022-10-27 12:50:15
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: awgn_channel_src_From_SSR_Q
-- Source Path: fec_ber_hw_V2/AWGN Channel/From SSR Q
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.awgn_channel_src_AWGN_Channel_pkg.ALL;

ENTITY awgn_channel_src_From_SSR_Q IS
  PORT( data_ssr                          :   IN    vector_of_std_logic_vector16(0 TO 7);  -- sfix16_En11 [8]
        data_wide                         :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
        );
END awgn_channel_src_From_SSR_Q;


ARCHITECTURE rtl OF awgn_channel_src_From_SSR_Q IS

  -- Signals
  SIGNAL data_ssr_7                       : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL data_ssr_6                       : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL data_ssr_5                       : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL data_ssr_4                       : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL data_ssr_3                       : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL data_ssr_2                       : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL data_ssr_1                       : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL data_ssr_0                       : signed(15 DOWNTO 0);  -- sfix16_En11
  SIGNAL bit_concat_out1                  : unsigned(127 DOWNTO 0);  -- ufix128

BEGIN
  data_ssr_7 <= signed(data_ssr(7));

  data_ssr_6 <= signed(data_ssr(6));

  data_ssr_5 <= signed(data_ssr(5));

  data_ssr_4 <= signed(data_ssr(4));

  data_ssr_3 <= signed(data_ssr(3));

  data_ssr_2 <= signed(data_ssr(2));

  data_ssr_1 <= signed(data_ssr(1));

  data_ssr_0 <= signed(data_ssr(0));

  bit_concat_out1 <= unsigned(data_ssr_7) & unsigned(data_ssr_6) & unsigned(data_ssr_5) & unsigned(data_ssr_4) & unsigned(data_ssr_3) & unsigned(data_ssr_2) & unsigned(data_ssr_1) & unsigned(data_ssr_0);

  data_wide <= std_logic_vector(bit_concat_out1);

END rtl;

