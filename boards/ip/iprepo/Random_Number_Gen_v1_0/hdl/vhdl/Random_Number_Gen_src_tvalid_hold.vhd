-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example_v2\Random_Number_Gen_src_tvalid_hold.vhd
-- Created: 2023-01-13 11:55:50
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Random_Number_Gen_src_tvalid_hold
-- Source Path: book_example_v2/Random Number Generator/tvalid hold
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Random_Number_Gen_src_tvalid_hold IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        en                                :   IN    std_logic;
        trigger                           :   IN    std_logic;
        comparator                        :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        enable                            :   OUT   std_logic
        );
END Random_Number_Gen_src_tvalid_hold;


ARCHITECTURE rtl OF Random_Number_Gen_src_tvalid_hold IS

  -- Signals
  SIGNAL comparator_unsigned              : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Multiport_Switch_out1            : std_logic;
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL AND_out1                         : std_logic;
  SIGNAL Equal_relop1                     : std_logic;
  SIGNAL HDL_Counter_out1                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL OR_out1                          : std_logic;

BEGIN
  comparator_unsigned <= unsigned(comparator);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_out1 <= Multiport_Switch_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  AND_out1 <= en AND Multiport_Switch_out1;

  -- Free running, Unsigned Counter
  --  initial value   = 0
  --  step value      = 8
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF Equal_relop1 = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(0, 32);
        ELSIF AND_out1 = '1' THEN 
          HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(8, 32);
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  
  Equal_relop1 <= '1' WHEN HDL_Counter_out1 >= comparator_unsigned ELSE
      '0';

  OR_out1 <= Equal_relop1 OR trigger;

  
  Multiport_Switch_out1 <= Delay2_out1 WHEN OR_out1 = '0' ELSE
      trigger;

  enable <= Multiport_Switch_out1;

END rtl;
