-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\fec_ber_hw\random_number_gen_dut.vhd
-- Created: 2022-10-06 14:58:27
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: random_number_gen_dut
-- Source Path: random_number_gen/random_number_gen_dut
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY random_number_gen_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        dut_enable                        :   IN    std_logic;  -- ufix1
        aximm_enable                      :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        aximm_comparator                  :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        ce_out                            :   OUT   std_logic;  -- ufix1
        m00_axis_tvalid                   :   OUT   std_logic;  -- ufix1
        m00_axis_tdata                    :   OUT   std_logic_vector(7 DOWNTO 0);  -- ufix8
        m01_axis_tvalid                   :   OUT   std_logic;  -- ufix1
        m01_axis_tdata                    :   OUT   std_logic_vector(7 DOWNTO 0)  -- ufix8
        );
END random_number_gen_dut;


ARCHITECTURE rtl OF random_number_gen_dut IS

  -- Component Declarations
  COMPONENT random_number_gen_src_Random_Number_Generator
    PORT( clk                             :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          reset                           :   IN    std_logic;
          aximm_enable                    :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          aximm_comparator                :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          ce_out                          :   OUT   std_logic;  -- ufix1
          m00_axis_tvalid                 :   OUT   std_logic;  -- ufix1
          m00_axis_tdata                  :   OUT   std_logic_vector(7 DOWNTO 0);  -- ufix8
          m01_axis_tvalid                 :   OUT   std_logic;  -- ufix1
          m01_axis_tdata                  :   OUT   std_logic_vector(7 DOWNTO 0)  -- ufix8
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : random_number_gen_src_Random_Number_Generator
    USE ENTITY work.random_number_gen_src_Random_Number_Generator(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL m00_axis_tvalid_sig              : std_logic;  -- ufix1
  SIGNAL m00_axis_tdata_sig               : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL m01_axis_tvalid_sig              : std_logic;  -- ufix1
  SIGNAL m01_axis_tdata_sig               : std_logic_vector(7 DOWNTO 0);  -- ufix8

BEGIN
  u_random_number_gen_src_Random_Number_Generator : random_number_gen_src_Random_Number_Generator
    PORT MAP( clk => clk,
              clk_enable => enb,
              reset => reset,
              aximm_enable => aximm_enable,  -- ufix32
              aximm_comparator => aximm_comparator,  -- ufix32
              ce_out => ce_out_sig,  -- ufix1
              m00_axis_tvalid => m00_axis_tvalid_sig,  -- ufix1
              m00_axis_tdata => m00_axis_tdata_sig,  -- ufix8
              m01_axis_tvalid => m01_axis_tvalid_sig,  -- ufix1
              m01_axis_tdata => m01_axis_tdata_sig  -- ufix8
              );

  enb <= dut_enable;

  ce_out <= ce_out_sig;

  m00_axis_tvalid <= m00_axis_tvalid_sig;

  m00_axis_tdata <= m00_axis_tdata_sig;

  m01_axis_tvalid <= m01_axis_tvalid_sig;

  m01_axis_tdata <= m01_axis_tdata_sig;

END rtl;

