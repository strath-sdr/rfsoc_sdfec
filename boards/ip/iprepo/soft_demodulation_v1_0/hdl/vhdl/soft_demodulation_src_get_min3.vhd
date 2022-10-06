-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\fec_ber_hw\soft_demodulation_src_get_min3.vhd
-- Created: 2022-10-06 15:14:46
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: soft_demodulation_src_get_min3
-- Source Path: fec_ber_hw/Soft Demodulation/Soft Demodulation/Subsystem1/get_min3
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY soft_demodulation_src_get_min3 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        a                                 :   IN    std_logic_vector(34 DOWNTO 0);  -- sfix35_En22
        b                                 :   IN    std_logic_vector(34 DOWNTO 0);  -- sfix35_En22
        min                               :   OUT   std_logic_vector(34 DOWNTO 0)  -- sfix35_En22
        );
END soft_demodulation_src_get_min3;


ARCHITECTURE rtl OF soft_demodulation_src_get_min3 IS

  -- Signals
  SIGNAL a_signed                         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_1                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL b_signed                         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL b_1                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Subtract18_sub_cast              : signed(35 DOWNTO 0);  -- sfix36_En22
  SIGNAL Subtract18_sub_cast_1            : signed(35 DOWNTO 0);  -- sfix36_En22
  SIGNAL Subtract18_sub_temp              : signed(35 DOWNTO 0);  -- sfix36_En22
  SIGNAL Subtract18_out1                  : signed(45 DOWNTO 0);  -- sfix46_En28
  SIGNAL Compare_To_Zero_out1             : std_logic;
  SIGNAL Multiport_Switch2_out1           : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_1         : signed(34 DOWNTO 0);  -- sfix35_En22

BEGIN
  a_signed <= signed(a);

  in_0_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a_1 <= to_signed(0, 35);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a_1 <= a_signed;
      END IF;
    END IF;
  END PROCESS in_0_pipe_process;


  b_signed <= signed(b);

  in_1_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      b_1 <= to_signed(0, 35);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        b_1 <= b_signed;
      END IF;
    END IF;
  END PROCESS in_1_pipe_process;


  Subtract18_sub_cast <= resize(a_1, 36);
  Subtract18_sub_cast_1 <= resize(b_1, 36);
  Subtract18_sub_temp <= Subtract18_sub_cast - Subtract18_sub_cast_1;
  Subtract18_out1 <= resize(Subtract18_sub_temp & '0' & '0' & '0' & '0' & '0' & '0', 46);

  
  Compare_To_Zero_out1 <= '1' WHEN Subtract18_out1 <= to_signed(0, 46) ELSE
      '0';

  
  Multiport_Switch2_out1 <= b_1 WHEN Compare_To_Zero_out1 = '0' ELSE
      a_1;

  out_0_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Multiport_Switch2_out1_1 <= to_signed(0, 35);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Multiport_Switch2_out1_1 <= Multiport_Switch2_out1;
      END IF;
    END IF;
  END PROCESS out_0_pipe_process;


  min <= std_logic_vector(Multiport_Switch2_out1_1);

END rtl;

