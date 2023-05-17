-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example\FEC_Ctrl_src_FEC_Ctrl.vhd
-- Created: 2022-11-23 17:53:26
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1.25e-08
-- Target subsystem base rate: 1.25e-08
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        1.25e-08
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- m_axis_ctrl_tvalid            ce_out        1.25e-08
-- m_axis_ctrl_tdata             ce_out        1.25e-08
-- m_axis_ctrl_tlast             ce_out        1.25e-08
-- m_axis_tvalid                 ce_out        1.25e-08
-- m_axis_tdata                  ce_out        1.25e-08
-- s_axis_status_tready          ce_out        1.25e-08
-- s_axis_tready                 ce_out        1.25e-08
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: FEC_Ctrl_src_FEC_Ctrl
-- Source Path: book_example/FEC Ctrl
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY FEC_Ctrl_src_FEC_Ctrl IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        aximm_ctrl                        :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        aximm_length                      :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        s_axis_tvalid                     :   IN    std_logic;
        s_axis_tdata                      :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        s_axis_status_tvalid              :   IN    std_logic;
        s_axis_status_tdata               :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        m_axis_tready                     :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        m_axis_ctrl_tvalid                :   OUT   std_logic;
        m_axis_ctrl_tdata                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        m_axis_ctrl_tlast                 :   OUT   std_logic;
        m_axis_tvalid                     :   OUT   std_logic;
        m_axis_tdata                      :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        s_axis_status_tready              :   OUT   std_logic;
        s_axis_tready                     :   OUT   std_logic
        );
END FEC_Ctrl_src_FEC_Ctrl;


ARCHITECTURE rtl OF FEC_Ctrl_src_FEC_Ctrl IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL aximm_length_unsigned            : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Constant_out1                    : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Subtract_out1                    : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL AND1_out1                        : std_logic;
  SIGNAL HDL_Counter_out1                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Equal_relop1                     : std_logic;
  SIGNAL Compare_To_Zero_out1             : std_logic;
  SIGNAL AND_out1                         : std_logic;
  SIGNAL Unit_Delay_Enabled_Synchronous1_out1 : std_logic;
  SIGNAL s_axis_tdata_unsigned            : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Unit_Delay_Enabled_Synchronous_out1 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Data_Type_Conversion_out1        : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL Constant1_out1                   : std_logic;

BEGIN
  aximm_length_unsigned <= unsigned(aximm_length);

  Constant_out1 <= to_unsigned(16#01#, 8);

  Subtract_out1 <= aximm_length_unsigned - resize(Constant_out1, 32);

  AND1_out1 <= s_axis_tvalid AND m_axis_tready;

  enb <= clk_enable;

  
  Equal_relop1 <= '1' WHEN HDL_Counter_out1 >= Subtract_out1 ELSE
      '0';

  -- Free running, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF Equal_relop1 = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(0, 32);
        ELSIF AND1_out1 = '1' THEN 
          HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(1, 32);
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  
  Compare_To_Zero_out1 <= '1' WHEN HDL_Counter_out1 = to_unsigned(0, 32) ELSE
      '0';

  AND_out1 <= Compare_To_Zero_out1 AND AND1_out1;

  Unit_Delay_Enabled_Synchronous1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_Enabled_Synchronous1_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND m_axis_tready = '1' THEN
        Unit_Delay_Enabled_Synchronous1_out1 <= AND1_out1;
      END IF;
    END IF;
  END PROCESS Unit_Delay_Enabled_Synchronous1_process;


  s_axis_tdata_unsigned <= unsigned(s_axis_tdata);

  Unit_Delay_Enabled_Synchronous_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_Enabled_Synchronous_out1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND m_axis_tready = '1' THEN
        Unit_Delay_Enabled_Synchronous_out1 <= s_axis_tdata_unsigned;
      END IF;
    END IF;
  END PROCESS Unit_Delay_Enabled_Synchronous_process;


  Data_Type_Conversion_out1 <= resize(Unit_Delay_Enabled_Synchronous_out1, 128);

  m_axis_tdata <= std_logic_vector(Data_Type_Conversion_out1);

  Constant1_out1 <= '1';

  ce_out <= clk_enable;

  m_axis_ctrl_tvalid <= AND_out1;

  m_axis_ctrl_tdata <= aximm_ctrl;

  m_axis_ctrl_tlast <= AND_out1;

  m_axis_tvalid <= Unit_Delay_Enabled_Synchronous1_out1;

  s_axis_status_tready <= Constant1_out1;

  s_axis_tready <= m_axis_tready;

END rtl;
