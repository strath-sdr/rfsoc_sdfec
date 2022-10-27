-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\BER_src_BER.vhd
-- Created: 2022-10-27 15:45:29
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1.5625e-09
-- Target subsystem base rate: 1.5625e-09
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        1.5625e-09
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- aximm_bit_error               ce_out        1.5625e-09
-- aximm_bit_count               ce_out        1.5625e-09
-- aximm_fifo_num                ce_out        1.5625e-09
-- ber_intr                      ce_out        1.5625e-09
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: BER_src_BER
-- Source Path: fec_ber_hw_V2/BER
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.BER_src_BER_pkg.ALL;

ENTITY BER_src_BER IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        aximm_bit_count_reset             :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        aximm_length                      :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        s_axis_decoded_tvalid             :   IN    std_logic;
        s_axis_decoded_tdata              :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        s_axis_orig_tvalid                :   IN    std_logic;
        s_axis_orig_tdata                 :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        ce_out                            :   OUT   std_logic;
        aximm_bit_error                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        aximm_bit_count                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        aximm_fifo_num                    :   OUT   std_logic_vector(13 DOWNTO 0);  -- ufix14
        ber_intr                          :   OUT   std_logic
        );
END BER_src_BER;


ARCHITECTURE rtl OF BER_src_BER IS

  -- Component Declarations
  COMPONENT BER_src_HDL_FIFO
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In_rsvd                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          Push                            :   IN    std_logic;
          Pop                             :   IN    std_logic;
          Out_rsvd                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
          Num                             :   OUT   std_logic_vector(13 DOWNTO 0)  -- ufix14
          );
  END COMPONENT;

  COMPONENT BER_src_Subsystem
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          original                        :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          decoded                         :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          reset_1                         :   IN    std_logic;
          Enable                          :   IN    std_logic;
          Bit_Error                       :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : BER_src_HDL_FIFO
    USE ENTITY work.BER_src_HDL_FIFO(rtl);

  FOR ALL : BER_src_Subsystem
    USE ENTITY work.BER_src_Subsystem(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL s_axis_orig_tdata_unsigned       : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL s_axis_orig_tdata_1              : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL s_axis_orig_tvalid_1             : std_logic;
  SIGNAL s_axis_decoded_tvalid_1          : std_logic;
  SIGNAL HDL_FIFO_out1                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL HDL_FIFO_out4                    : std_logic_vector(13 DOWNTO 0);  -- ufix14
  SIGNAL s_axis_decoded_tdata_unsigned    : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL s_axis_decoded_tdata_1           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Bit_Slice_out1                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Delay1_out1                      : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL aximm_bit_count_reset_unsigned   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL aximm_bit_count_reset_1          : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Cast_To_Boolean_out1             : std_logic;
  SIGNAL Delay3_out1                      : std_logic;
  SIGNAL OR_out1                          : std_logic;
  SIGNAL Subsystem_out1                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Subsystem_out1_unsigned          : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Subsystem_out1_1                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL HDL_Counter_out1                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL delayMatch_reg                   : vector_of_unsigned32(0 TO 2);  -- ufix32 [3]
  SIGNAL HDL_Counter_out1_1               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL HDL_FIFO_out4_unsigned           : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL delayMatch1_reg                  : vector_of_unsigned14(0 TO 2);  -- ufix14 [3]
  SIGNAL HDL_FIFO_out4_1                  : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL aximm_length_unsigned            : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL aximm_length_1                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Equal_relop1                     : std_logic;
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL Logical_Operator1_out1           : std_logic;
  SIGNAL delayMatch2_reg                  : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL Logical_Operator1_out1_1         : std_logic;

BEGIN
  u_HDL_FIFO : BER_src_HDL_FIFO
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              In_rsvd => std_logic_vector(s_axis_orig_tdata_1),  -- uint32
              Push => s_axis_orig_tvalid_1,
              Pop => s_axis_decoded_tvalid_1,
              Out_rsvd => HDL_FIFO_out1,  -- uint32
              Num => HDL_FIFO_out4  -- ufix14
              );

  u_Subsystem : BER_src_Subsystem
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              original => HDL_FIFO_out1,  -- uint32
              decoded => std_logic_vector(Delay1_out1),  -- uint8
              reset_1 => Cast_To_Boolean_out1,
              Enable => OR_out1,
              Bit_Error => Subsystem_out1  -- uint32
              );

  s_axis_orig_tdata_unsigned <= unsigned(s_axis_orig_tdata);

  enb <= clk_enable;

  in_5_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      s_axis_orig_tdata_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        s_axis_orig_tdata_1 <= s_axis_orig_tdata_unsigned;
      END IF;
    END IF;
  END PROCESS in_5_pipe_process;


  in_4_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      s_axis_orig_tvalid_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        s_axis_orig_tvalid_1 <= s_axis_orig_tvalid;
      END IF;
    END IF;
  END PROCESS in_4_pipe_process;


  in_2_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      s_axis_decoded_tvalid_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        s_axis_decoded_tvalid_1 <= s_axis_decoded_tvalid;
      END IF;
    END IF;
  END PROCESS in_2_pipe_process;


  s_axis_decoded_tdata_unsigned <= unsigned(s_axis_decoded_tdata);

  in_3_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      s_axis_decoded_tdata_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        s_axis_decoded_tdata_1 <= s_axis_decoded_tdata_unsigned;
      END IF;
    END IF;
  END PROCESS in_3_pipe_process;


  Bit_Slice_out1 <= s_axis_decoded_tdata_1(7 DOWNTO 0);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay1_out1 <= Bit_Slice_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  aximm_bit_count_reset_unsigned <= unsigned(aximm_bit_count_reset);

  in_0_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      aximm_bit_count_reset_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        aximm_bit_count_reset_1 <= aximm_bit_count_reset_unsigned;
      END IF;
    END IF;
  END PROCESS in_0_pipe_process;


  
  Cast_To_Boolean_out1 <= '1' WHEN aximm_bit_count_reset_1 /= to_unsigned(0, 32) ELSE
      '0';

  Delay3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay3_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay3_out1 <= s_axis_decoded_tvalid_1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  OR_out1 <= Cast_To_Boolean_out1 OR Delay3_out1;

  Subsystem_out1_unsigned <= unsigned(Subsystem_out1);

  out_0_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Subsystem_out1_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Subsystem_out1_1 <= Subsystem_out1_unsigned;
      END IF;
    END IF;
  END PROCESS out_0_pipe_process;


  aximm_bit_error <= std_logic_vector(Subsystem_out1_1);

  -- Free running, Unsigned Counter
  --  initial value   = 0
  --  step value      = 32
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF Cast_To_Boolean_out1 = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(0, 32);
        ELSIF Delay3_out1 = '1' THEN 
          HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(32, 32);
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => to_unsigned(0, 32));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= HDL_Counter_out1;
        delayMatch_reg(1 TO 2) <= delayMatch_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  HDL_Counter_out1_1 <= delayMatch_reg(2);

  aximm_bit_count <= std_logic_vector(HDL_Counter_out1_1);

  HDL_FIFO_out4_unsigned <= unsigned(HDL_FIFO_out4);

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch1_reg <= (OTHERS => to_unsigned(16#0000#, 14));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch1_reg(0) <= HDL_FIFO_out4_unsigned;
        delayMatch1_reg(1 TO 2) <= delayMatch1_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS delayMatch1_process;

  HDL_FIFO_out4_1 <= delayMatch1_reg(2);

  aximm_fifo_num <= std_logic_vector(HDL_FIFO_out4_1);

  aximm_length_unsigned <= unsigned(aximm_length);

  in_1_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      aximm_length_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        aximm_length_1 <= aximm_length_unsigned;
      END IF;
    END IF;
  END PROCESS in_1_pipe_process;


  
  Equal_relop1 <= '1' WHEN HDL_Counter_out1 = aximm_length_1 ELSE
      '0';

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_out1 <= '1';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay2_out1 <= Equal_relop1;
      END IF;
    END IF;
  END PROCESS Delay2_process;


  Logical_Operator_out1 <=  NOT Delay2_out1;

  Logical_Operator1_out1 <= Equal_relop1 AND Logical_Operator_out1;

  delayMatch2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch2_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch2_reg(0) <= Logical_Operator1_out1;
        delayMatch2_reg(1 TO 2) <= delayMatch2_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS delayMatch2_process;

  Logical_Operator1_out1_1 <= delayMatch2_reg(2);

  ce_out <= clk_enable;

  ber_intr <= Logical_Operator1_out1_1;

END rtl;

