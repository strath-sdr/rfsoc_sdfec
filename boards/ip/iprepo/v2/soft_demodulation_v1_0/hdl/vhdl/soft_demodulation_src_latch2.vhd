-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits_hmm\hdlsrc\fec_ber_hw_V2\soft_demodulation_src_latch2.vhd
-- Created: 2022-10-27 17:56:31
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: soft_demodulation_src_latch2
-- Source Path: fec_ber_hw_V2/Soft Demodulation/Subsystem2/latch2
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.soft_demodulation_src_Soft_Demodulation_pkg.ALL;

ENTITY soft_demodulation_src_latch2 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        en                                :   IN    std_logic;
        data_in                           :   IN    vector_of_std_logic_vector8(0 TO 15);  -- uint8 [16]
        data_out                          :   OUT   vector_of_std_logic_vector8(0 TO 15)  -- uint8 [16]
        );
END soft_demodulation_src_latch2;


ARCHITECTURE rtl OF soft_demodulation_src_latch2 IS

  -- Signals
  SIGNAL delayMatch_reg                   : std_logic_vector(0 TO 16);  -- ufix1 [17]
  SIGNAL en_1                             : std_logic;
  SIGNAL data_in_unsigned                 : vector_of_unsigned8(0 TO 15);  -- uint8 [16]
  SIGNAL Multiport_Switch_out1            : vector_of_unsigned8(0 TO 15);  -- uint8 [16]
  SIGNAL Delay3_out1                      : vector_of_unsigned8(0 TO 15);  -- uint8 [16]

BEGIN
  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= en;
        delayMatch_reg(1 TO 16) <= delayMatch_reg(0 TO 15);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  en_1 <= delayMatch_reg(16);

  outputgen1: FOR k IN 0 TO 15 GENERATE
    data_in_unsigned(k) <= unsigned(data_in(k));
  END GENERATE;

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= (OTHERS => to_unsigned(16#00#, 8));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_out1 <= Multiport_Switch_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  
  Multiport_Switch_out1 <= Delay3_out1 WHEN en_1 = '0' ELSE
      data_in_unsigned;

  outputgen: FOR k IN 0 TO 15 GENERATE
    data_out(k) <= std_logic_vector(Multiport_Switch_out1(k));
  END GENERATE;

END rtl;

