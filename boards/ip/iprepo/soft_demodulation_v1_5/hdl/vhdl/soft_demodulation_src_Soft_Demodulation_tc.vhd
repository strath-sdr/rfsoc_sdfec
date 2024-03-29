-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example\soft_demodulation_src_Soft_Demodulation_tc.vhd
-- Created: 2022-11-22 20:40:30
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: soft_demodulation_src_Soft_Demodulation_tc
-- Source Path: Soft Demodulation_tc
-- Hierarchy Level: 1
-- 
-- Master clock enable input: clk_enable
-- 
-- enb         : identical to clk_enable
-- enb_1_2_0   : 2x slower than clk with last phase
-- enb_1_2_1   : 2x slower than clk with phase 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY soft_demodulation_src_Soft_Demodulation_tc IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        enb                               :   OUT   std_logic;
        enb_1_2_0                         :   OUT   std_logic;
        enb_1_2_1                         :   OUT   std_logic
        );
END soft_demodulation_src_Soft_Demodulation_tc;


ARCHITECTURE rtl OF soft_demodulation_src_Soft_Demodulation_tc IS

  -- Signals
  SIGNAL count2                           : std_logic;
  SIGNAL phase_all                        : std_logic;
  SIGNAL phase_0                          : std_logic;
  SIGNAL phase_0_tmp                      : std_logic;
  SIGNAL phase_1                          : std_logic;
  SIGNAL phase_1_tmp                      : std_logic;

BEGIN
  Counter2 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      count2 <= '1';
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
          count2 <= NOT count2;
      END IF;
    END IF; 
  END PROCESS Counter2;

  phase_all <= '1' WHEN clk_enable = '1' ELSE '0';

  temp_process1 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_0 <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        phase_0 <= phase_0_tmp;
      END IF;
    END IF; 
  END PROCESS temp_process1;

  phase_0_tmp <= '1' WHEN count2 = '1' AND clk_enable = '1' ELSE '0';

  temp_process2 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_1 <= '1';
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        phase_1 <= phase_1_tmp;
      END IF;
    END IF; 
  END PROCESS temp_process2;

  phase_1_tmp <= '1' WHEN count2 = '0' AND clk_enable = '1' ELSE '0';

  enb <=  phase_all AND clk_enable;

  enb_1_2_0 <=  phase_0 AND clk_enable;

  enb_1_2_1 <=  phase_1 AND clk_enable;


END rtl;

