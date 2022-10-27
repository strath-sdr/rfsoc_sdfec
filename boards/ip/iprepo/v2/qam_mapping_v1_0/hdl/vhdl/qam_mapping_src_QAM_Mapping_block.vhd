-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\qam_mapping_src_QAM_Mapping_block.vhd
-- Created: 2022-10-27 12:38:09
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: qam_mapping_src_QAM_Mapping_block
-- Source Path: fec_ber_hw_V2/QAM Mapping/QAM Mapping
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY qam_mapping_src_QAM_Mapping_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        bits_lane0                        :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        Enable                            :   IN    std_logic;
        Q_symbols                         :   OUT   std_logic_vector(47 DOWNTO 0);  -- ufix48
        I_symbols                         :   OUT   std_logic_vector(47 DOWNTO 0)  -- ufix48
        );
END qam_mapping_src_QAM_Mapping_block;


ARCHITECTURE rtl OF qam_mapping_src_QAM_Mapping_block IS

  -- Component Declarations
  COMPONENT qam_mapping_src_N_Width_QAM_16_Symbol_Mapping_Imag
    PORT( bits                            :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          symbol                          :   OUT   std_logic_vector(47 DOWNTO 0)  -- ufix48
          );
  END COMPONENT;

  COMPONENT qam_mapping_src_N_Width_QAM_16_Symbol_Mapping_Real
    PORT( bits                            :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          symbol                          :   OUT   std_logic_vector(47 DOWNTO 0)  -- ufix48
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : qam_mapping_src_N_Width_QAM_16_Symbol_Mapping_Imag
    USE ENTITY work.qam_mapping_src_N_Width_QAM_16_Symbol_Mapping_Imag(rtl);

  FOR ALL : qam_mapping_src_N_Width_QAM_16_Symbol_Mapping_Real
    USE ENTITY work.qam_mapping_src_N_Width_QAM_16_Symbol_Mapping_Real(rtl);

  -- Signals
  SIGNAL enb_1_4_0_gated                  : std_logic;
  SIGNAL Enable_out2                      : std_logic;
  SIGNAL y                                : std_logic_vector(47 DOWNTO 0);  -- ufix48
  SIGNAL y_unsigned                       : unsigned(47 DOWNTO 0);  -- ufix48
  SIGNAL y_bypass                         : unsigned(47 DOWNTO 0);  -- ufix48
  SIGNAL y_last_value                     : unsigned(47 DOWNTO 0);  -- ufix48
  SIGNAL y_1                              : std_logic_vector(47 DOWNTO 0);  -- ufix48
  SIGNAL y_unsigned_1                     : unsigned(47 DOWNTO 0);  -- ufix48
  SIGNAL y_bypass_1                       : unsigned(47 DOWNTO 0);  -- ufix48
  SIGNAL y_last_value_1                   : unsigned(47 DOWNTO 0);  -- ufix48

BEGIN
  u_N_Width_QAM_16_Symbol_Mapping_Imag : qam_mapping_src_N_Width_QAM_16_Symbol_Mapping_Imag
    PORT MAP( bits => bits_lane0,  -- ufix64
              symbol => y  -- ufix48
              );

  u_N_Width_QAM_16_Symbol_Mapping_Real : qam_mapping_src_N_Width_QAM_16_Symbol_Mapping_Real
    PORT MAP( bits => bits_lane0,  -- ufix64
              symbol => y_1  -- ufix48
              );

  Enable_out2 <= Enable;

  enb_1_4_0_gated <= Enable_out2 AND enb_1_4_0;

  y_unsigned <= unsigned(y);

  Q_symbols_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      y_last_value <= to_unsigned(0, 48);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0_gated = '1' THEN
        y_last_value <= y_bypass;
      END IF;
    END IF;
  END PROCESS Q_symbols_bypass_process;


  
  y_bypass <= y_last_value WHEN Enable_out2 = '0' ELSE
      y_unsigned;

  Q_symbols <= std_logic_vector(y_bypass);

  y_unsigned_1 <= unsigned(y_1);

  I_symbols_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      y_last_value_1 <= to_unsigned(0, 48);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0_gated = '1' THEN
        y_last_value_1 <= y_bypass_1;
      END IF;
    END IF;
  END PROCESS I_symbols_bypass_process;


  
  y_bypass_1 <= y_last_value_1 WHEN Enable_out2 = '0' ELSE
      y_unsigned_1;

  I_symbols <= std_logic_vector(y_bypass_1);

END rtl;

