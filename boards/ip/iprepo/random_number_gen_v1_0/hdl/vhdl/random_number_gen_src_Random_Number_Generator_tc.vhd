-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\fec_ber_hw\random_number_gen_src_Random_Number_Generator_tc.vhd
-- Created: 2022-10-06 14:58:23
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: random_number_gen_src_Random_Number_Generator_tc
-- Source Path: Random Number Generator_tc
-- Hierarchy Level: 1
-- 
-- Master clock enable input: clk_enable
-- 
-- enb_1_1_1   : identical to clk_enable
-- enb_1_16_0  : 16x slower than clk with last phase
-- enb_1_16_1  : 16x slower than clk with phase 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY random_number_gen_src_Random_Number_Generator_tc IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        enb_1_1_1                         :   OUT   std_logic;
        enb_1_16_0                        :   OUT   std_logic;
        enb_1_16_1                        :   OUT   std_logic
        );
END random_number_gen_src_Random_Number_Generator_tc;


ARCHITECTURE rtl OF random_number_gen_src_Random_Number_Generator_tc IS

  -- Signals
  SIGNAL count16                          : unsigned(3 DOWNTO 0);  -- ufix4
  SIGNAL phase_all                        : std_logic;
  SIGNAL phase_0                          : std_logic;
  SIGNAL phase_0_tmp                      : std_logic;
  SIGNAL phase_1                          : std_logic;
  SIGNAL phase_1_tmp                      : std_logic;

  ATTRIBUTE keep : string;
  ATTRIBUTE mcp_info : string;

  ATTRIBUTE keep OF phase_0 : SIGNAL IS "true";
  ATTRIBUTE mcp_info OF phase_0 : SIGNAL IS "Random Number Generator_tc.u1_d16_o0";

BEGIN
  Counter16 : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      count16 <= to_unsigned(1, 4);
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        IF count16 >= to_unsigned(15, 4) THEN
          count16 <= to_unsigned(0, 4);
        ELSE
          count16 <= count16 + to_unsigned(1, 4);
        END IF;
      END IF;
    END IF; 
  END PROCESS Counter16;

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

  phase_0_tmp <= '1' WHEN count16 = to_unsigned(15, 4) AND clk_enable = '1' ELSE '0';

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

  phase_1_tmp <= '1' WHEN count16 = to_unsigned(0, 4) AND clk_enable = '1' ELSE '0';

  enb_1_1_1 <=  phase_all AND clk_enable;

  enb_1_16_0 <=  phase_0 AND clk_enable;

  enb_1_16_1 <=  phase_1 AND clk_enable;


END rtl;
