-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits_hmm\hdlsrc\fec_ber_hw_V2\soft_demodulation_src_get_min3_block.vhd
-- Created: 2022-10-27 17:56:31
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: soft_demodulation_src_get_min3_block
-- Source Path: fec_ber_hw_V2/Soft Demodulation/Soft Demodulation/Subsystem2/get_min3
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.soft_demodulation_src_Soft_Demodulation_pkg.ALL;

ENTITY soft_demodulation_src_get_min3_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        a                                 :   IN    vector_of_std_logic_vector35(0 TO 15);  -- sfix35_En22 [16]
        b                                 :   IN    vector_of_std_logic_vector35(0 TO 15);  -- sfix35_En22 [16]
        min                               :   OUT   vector_of_std_logic_vector35(0 TO 15)  -- sfix35_En22 [16]
        );
END soft_demodulation_src_get_min3_block;


ARCHITECTURE rtl OF soft_demodulation_src_get_min3_block IS

  -- Signals
  SIGNAL a_signed                         : vector_of_signed35(0 TO 15);  -- sfix35_En22 [16]
  SIGNAL a_1                              : vector_of_signed35(0 TO 15);  -- sfix35_En22 [16]
  SIGNAL b_signed                         : vector_of_signed35(0 TO 15);  -- sfix35_En22 [16]
  SIGNAL b_1                              : vector_of_signed35(0 TO 15);  -- sfix35_En22 [16]
  SIGNAL Subtract18_sub_cast              : vector_of_signed36(0 TO 15);  -- sfix36_En22 [16]
  SIGNAL Subtract18_sub_cast_1            : vector_of_signed36(0 TO 15);  -- sfix36_En22 [16]
  SIGNAL Subtract18_out1                  : vector_of_signed36(0 TO 15);  -- sfix36_En22 [16]
  SIGNAL Compare_To_Zero_out1             : std_logic_vector(0 TO 15);  -- boolean [16]
  SIGNAL Compare_To_Zero_out1_0           : std_logic;
  SIGNAL b_0                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_1           : std_logic;
  SIGNAL b_1_1                            : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_2           : std_logic;
  SIGNAL b_2                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_3           : std_logic;
  SIGNAL b_3                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_4           : std_logic;
  SIGNAL b_4                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_5           : std_logic;
  SIGNAL b_5                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_6           : std_logic;
  SIGNAL b_6                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_7           : std_logic;
  SIGNAL b_7                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_8           : std_logic;
  SIGNAL b_8                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_9           : std_logic;
  SIGNAL b_9                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_10          : std_logic;
  SIGNAL b_10                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_11          : std_logic;
  SIGNAL b_11                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_12          : std_logic;
  SIGNAL b_12                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_13          : std_logic;
  SIGNAL b_13                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_14          : std_logic;
  SIGNAL b_14                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Compare_To_Zero_out1_15          : std_logic;
  SIGNAL b_15                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_0                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_0         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_1_1                            : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_1         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_2                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_2         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_3                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_3         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_4                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_4         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_5                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_5         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_6                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_6         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_7                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_7         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_8                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_8         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_9                              : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_9         : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_10                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_10        : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_11                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_11        : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_12                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_12        : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_13                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_13        : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_14                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_14        : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL a_15                             : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1_15        : signed(34 DOWNTO 0);  -- sfix35_En22
  SIGNAL Multiport_Switch2_out1           : vector_of_signed35(0 TO 15);  -- sfix35_En22 [16]
  SIGNAL Multiport_Switch2_out1_16        : vector_of_signed35(0 TO 15);  -- sfix35_En22 [16]

BEGIN
  outputgen2: FOR k IN 0 TO 15 GENERATE
    a_signed(k) <= signed(a(k));
  END GENERATE;

  in_0_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      a_1 <= (OTHERS => to_signed(0, 35));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        a_1 <= a_signed;
      END IF;
    END IF;
  END PROCESS in_0_pipe_process;


  outputgen1: FOR k IN 0 TO 15 GENERATE
    b_signed(k) <= signed(b(k));
  END GENERATE;

  in_1_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      b_1 <= (OTHERS => to_signed(0, 35));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        b_1 <= b_signed;
      END IF;
    END IF;
  END PROCESS in_1_pipe_process;



  Subtract18_out1_gen: FOR t_0 IN 0 TO 15 GENERATE
    Subtract18_sub_cast(t_0) <= resize(a_1(t_0), 36);
    Subtract18_sub_cast_1(t_0) <= resize(b_1(t_0), 36);
    Subtract18_out1(t_0) <= Subtract18_sub_cast(t_0) - Subtract18_sub_cast_1(t_0);
  END GENERATE Subtract18_out1_gen;



  Compare_To_Zero_out1_gen: FOR t_01 IN 0 TO 15 GENERATE
    
    Compare_To_Zero_out1(t_01) <= '1' WHEN Subtract18_out1(t_01) <= to_signed(0, 36) ELSE
        '0';
  END GENERATE Compare_To_Zero_out1_gen;


  Compare_To_Zero_out1_0 <= Compare_To_Zero_out1(0);

  b_0 <= b_1(0);

  Compare_To_Zero_out1_1 <= Compare_To_Zero_out1(1);

  b_1_1 <= b_1(1);

  Compare_To_Zero_out1_2 <= Compare_To_Zero_out1(2);

  b_2 <= b_1(2);

  Compare_To_Zero_out1_3 <= Compare_To_Zero_out1(3);

  b_3 <= b_1(3);

  Compare_To_Zero_out1_4 <= Compare_To_Zero_out1(4);

  b_4 <= b_1(4);

  Compare_To_Zero_out1_5 <= Compare_To_Zero_out1(5);

  b_5 <= b_1(5);

  Compare_To_Zero_out1_6 <= Compare_To_Zero_out1(6);

  b_6 <= b_1(6);

  Compare_To_Zero_out1_7 <= Compare_To_Zero_out1(7);

  b_7 <= b_1(7);

  Compare_To_Zero_out1_8 <= Compare_To_Zero_out1(8);

  b_8 <= b_1(8);

  Compare_To_Zero_out1_9 <= Compare_To_Zero_out1(9);

  b_9 <= b_1(9);

  Compare_To_Zero_out1_10 <= Compare_To_Zero_out1(10);

  b_10 <= b_1(10);

  Compare_To_Zero_out1_11 <= Compare_To_Zero_out1(11);

  b_11 <= b_1(11);

  Compare_To_Zero_out1_12 <= Compare_To_Zero_out1(12);

  b_12 <= b_1(12);

  Compare_To_Zero_out1_13 <= Compare_To_Zero_out1(13);

  b_13 <= b_1(13);

  Compare_To_Zero_out1_14 <= Compare_To_Zero_out1(14);

  b_14 <= b_1(14);

  Compare_To_Zero_out1_15 <= Compare_To_Zero_out1(15);

  b_15 <= b_1(15);

  a_0 <= a_1(0);

  
  Multiport_Switch2_out1_0 <= b_0 WHEN Compare_To_Zero_out1_0 = '0' ELSE
      a_0;

  a_1_1 <= a_1(1);

  
  Multiport_Switch2_out1_1 <= b_1_1 WHEN Compare_To_Zero_out1_1 = '0' ELSE
      a_1_1;

  a_2 <= a_1(2);

  
  Multiport_Switch2_out1_2 <= b_2 WHEN Compare_To_Zero_out1_2 = '0' ELSE
      a_2;

  a_3 <= a_1(3);

  
  Multiport_Switch2_out1_3 <= b_3 WHEN Compare_To_Zero_out1_3 = '0' ELSE
      a_3;

  a_4 <= a_1(4);

  
  Multiport_Switch2_out1_4 <= b_4 WHEN Compare_To_Zero_out1_4 = '0' ELSE
      a_4;

  a_5 <= a_1(5);

  
  Multiport_Switch2_out1_5 <= b_5 WHEN Compare_To_Zero_out1_5 = '0' ELSE
      a_5;

  a_6 <= a_1(6);

  
  Multiport_Switch2_out1_6 <= b_6 WHEN Compare_To_Zero_out1_6 = '0' ELSE
      a_6;

  a_7 <= a_1(7);

  
  Multiport_Switch2_out1_7 <= b_7 WHEN Compare_To_Zero_out1_7 = '0' ELSE
      a_7;

  a_8 <= a_1(8);

  
  Multiport_Switch2_out1_8 <= b_8 WHEN Compare_To_Zero_out1_8 = '0' ELSE
      a_8;

  a_9 <= a_1(9);

  
  Multiport_Switch2_out1_9 <= b_9 WHEN Compare_To_Zero_out1_9 = '0' ELSE
      a_9;

  a_10 <= a_1(10);

  
  Multiport_Switch2_out1_10 <= b_10 WHEN Compare_To_Zero_out1_10 = '0' ELSE
      a_10;

  a_11 <= a_1(11);

  
  Multiport_Switch2_out1_11 <= b_11 WHEN Compare_To_Zero_out1_11 = '0' ELSE
      a_11;

  a_12 <= a_1(12);

  
  Multiport_Switch2_out1_12 <= b_12 WHEN Compare_To_Zero_out1_12 = '0' ELSE
      a_12;

  a_13 <= a_1(13);

  
  Multiport_Switch2_out1_13 <= b_13 WHEN Compare_To_Zero_out1_13 = '0' ELSE
      a_13;

  a_14 <= a_1(14);

  
  Multiport_Switch2_out1_14 <= b_14 WHEN Compare_To_Zero_out1_14 = '0' ELSE
      a_14;

  a_15 <= a_1(15);

  
  Multiport_Switch2_out1_15 <= b_15 WHEN Compare_To_Zero_out1_15 = '0' ELSE
      a_15;

  Multiport_Switch2_out1(0) <= Multiport_Switch2_out1_0;
  Multiport_Switch2_out1(1) <= Multiport_Switch2_out1_1;
  Multiport_Switch2_out1(2) <= Multiport_Switch2_out1_2;
  Multiport_Switch2_out1(3) <= Multiport_Switch2_out1_3;
  Multiport_Switch2_out1(4) <= Multiport_Switch2_out1_4;
  Multiport_Switch2_out1(5) <= Multiport_Switch2_out1_5;
  Multiport_Switch2_out1(6) <= Multiport_Switch2_out1_6;
  Multiport_Switch2_out1(7) <= Multiport_Switch2_out1_7;
  Multiport_Switch2_out1(8) <= Multiport_Switch2_out1_8;
  Multiport_Switch2_out1(9) <= Multiport_Switch2_out1_9;
  Multiport_Switch2_out1(10) <= Multiport_Switch2_out1_10;
  Multiport_Switch2_out1(11) <= Multiport_Switch2_out1_11;
  Multiport_Switch2_out1(12) <= Multiport_Switch2_out1_12;
  Multiport_Switch2_out1(13) <= Multiport_Switch2_out1_13;
  Multiport_Switch2_out1(14) <= Multiport_Switch2_out1_14;
  Multiport_Switch2_out1(15) <= Multiport_Switch2_out1_15;

  out_0_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Multiport_Switch2_out1_16 <= (OTHERS => to_signed(0, 35));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Multiport_Switch2_out1_16 <= Multiport_Switch2_out1;
      END IF;
    END IF;
  END PROCESS out_0_pipe_process;


  outputgen: FOR k IN 0 TO 15 GENERATE
    min(k) <= std_logic_vector(Multiport_Switch2_out1_16(k));
  END GENERATE;

END rtl;

