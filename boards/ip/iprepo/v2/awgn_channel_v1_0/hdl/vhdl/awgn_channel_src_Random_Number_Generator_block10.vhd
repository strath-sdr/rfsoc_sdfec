-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\awgn_channel_src_Random_Number_Generator_block10.vhd
-- Created: 2022-10-27 12:50:15
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: awgn_channel_src_Random_Number_Generator_block10
-- Source Path: fec_ber_hw_V2/AWGN Channel/AWGN/Subsystem1/AWGN Generator3/Random Number Generator
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY awgn_channel_src_Random_Number_Generator_block10 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        reset_1                           :   IN    std_logic;
        enable                            :   IN    std_logic;
        data                              :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
        );
END awgn_channel_src_Random_Number_Generator_block10;


ARCHITECTURE rtl OF awgn_channel_src_Random_Number_Generator_block10 IS

  -- Component Declarations
  COMPONENT awgn_channel_src_bit0_block21
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          inportReset                     :   IN    std_logic;
          PN_Sequence                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_bit1_block21
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          inportReset                     :   IN    std_logic;
          PN_Sequence                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_bit2_block21
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          inportReset                     :   IN    std_logic;
          PN_Sequence                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_bit3_block21
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          inportReset                     :   IN    std_logic;
          PN_Sequence                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_bit4_block21
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          inportReset                     :   IN    std_logic;
          PN_Sequence                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_bit5_block21
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          inportReset                     :   IN    std_logic;
          PN_Sequence                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_bit6_block21
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          inportReset                     :   IN    std_logic;
          PN_Sequence                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_bit7_block21
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          inportReset                     :   IN    std_logic;
          PN_Sequence                     :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : awgn_channel_src_bit0_block21
    USE ENTITY work.awgn_channel_src_bit0_block21(rtl);

  FOR ALL : awgn_channel_src_bit1_block21
    USE ENTITY work.awgn_channel_src_bit1_block21(rtl);

  FOR ALL : awgn_channel_src_bit2_block21
    USE ENTITY work.awgn_channel_src_bit2_block21(rtl);

  FOR ALL : awgn_channel_src_bit3_block21
    USE ENTITY work.awgn_channel_src_bit3_block21(rtl);

  FOR ALL : awgn_channel_src_bit4_block21
    USE ENTITY work.awgn_channel_src_bit4_block21(rtl);

  FOR ALL : awgn_channel_src_bit5_block21
    USE ENTITY work.awgn_channel_src_bit5_block21(rtl);

  FOR ALL : awgn_channel_src_bit6_block21
    USE ENTITY work.awgn_channel_src_bit6_block21(rtl);

  FOR ALL : awgn_channel_src_bit7_block21
    USE ENTITY work.awgn_channel_src_bit7_block21(rtl);

  -- Signals
  SIGNAL enb_1_4_0_gated                  : std_logic;
  SIGNAL enable_out2                      : std_logic;
  SIGNAL bit0_out1                        : std_logic;
  SIGNAL bit1_out1                        : std_logic;
  SIGNAL bit2_out1                        : std_logic;
  SIGNAL bit3_out1                        : std_logic;
  SIGNAL bit4_out1                        : std_logic;
  SIGNAL bit5_out1                        : std_logic;
  SIGNAL bit6_out1                        : std_logic;
  SIGNAL bit7_out1                        : std_logic;
  SIGNAL concat_out1                      : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL concat_out1_bypass               : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL concat_out1_last_value           : unsigned(7 DOWNTO 0);  -- uint8

BEGIN
  u_bit0 : awgn_channel_src_bit0_block21
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0_gated,
              inportReset => reset_1,
              PN_Sequence => bit0_out1
              );

  u_bit1 : awgn_channel_src_bit1_block21
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0_gated,
              inportReset => reset_1,
              PN_Sequence => bit1_out1
              );

  u_bit2 : awgn_channel_src_bit2_block21
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0_gated,
              inportReset => reset_1,
              PN_Sequence => bit2_out1
              );

  u_bit3 : awgn_channel_src_bit3_block21
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0_gated,
              inportReset => reset_1,
              PN_Sequence => bit3_out1
              );

  u_bit4 : awgn_channel_src_bit4_block21
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0_gated,
              inportReset => reset_1,
              PN_Sequence => bit4_out1
              );

  u_bit5 : awgn_channel_src_bit5_block21
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0_gated,
              inportReset => reset_1,
              PN_Sequence => bit5_out1
              );

  u_bit6 : awgn_channel_src_bit6_block21
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0_gated,
              inportReset => reset_1,
              PN_Sequence => bit6_out1
              );

  u_bit7 : awgn_channel_src_bit7_block21
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0_gated,
              inportReset => reset_1,
              PN_Sequence => bit7_out1
              );

  enable_out2 <= enable;

  enb_1_4_0_gated <= enable_out2 AND enb_1_4_0;

  concat_out1 <= unsigned'(bit0_out1 & bit1_out1 & bit2_out1 & bit3_out1 & bit4_out1 & bit5_out1 & bit6_out1 & bit7_out1);

  data_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      concat_out1_last_value <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0_gated = '1' THEN
        concat_out1_last_value <= concat_out1_bypass;
      END IF;
    END IF;
  END PROCESS data_bypass_process;


  
  concat_out1_bypass <= concat_out1_last_value WHEN enable_out2 = '0' ELSE
      concat_out1;

  data <= std_logic_vector(concat_out1_bypass);

END rtl;

