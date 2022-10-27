-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\awgn_channel_src_AWGN_Channel.vhd
-- Created: 2022-10-27 12:50:15
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1.5625e-09
-- Target subsystem base rate: 6.25e-09
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        6.25e-09
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- m00_axis_Q_tvalid             ce_out        6.25e-09
-- m00_axis_Q_tdata              ce_out        6.25e-09
-- m01_axis_Q_tvalid             ce_out        6.25e-09
-- m01_axis_Q_tdata              ce_out        6.25e-09
-- m00_axis_I_tvalid             ce_out        6.25e-09
-- m00_axis_I_tdata              ce_out        6.25e-09
-- m01_axis_I_tvalid             ce_out        6.25e-09
-- m01_axis_I_tdata              ce_out        6.25e-09
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: awgn_channel_src_AWGN_Channel
-- Source Path: fec_ber_hw_V2/AWGN Channel
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.awgn_channel_src_AWGN_Channel_pkg.ALL;

ENTITY awgn_channel_src_AWGN_Channel IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        aximm_noise_std                   :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
        aximm_awgn_reset                  :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        s_axis_Q_tvalid                   :   IN    std_logic;
        s_axis_Q_tdata                    :   IN    std_logic_vector(47 DOWNTO 0);  -- ufix48
        s_axis_I_tvalid                   :   IN    std_logic;
        s_axis_I_tdata                    :   IN    std_logic_vector(47 DOWNTO 0);  -- ufix48
        ce_out                            :   OUT   std_logic;
        m00_axis_Q_tvalid                 :   OUT   std_logic;
        m00_axis_Q_tdata                  :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m01_axis_Q_tvalid                 :   OUT   std_logic;
        m01_axis_Q_tdata                  :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m00_axis_I_tvalid                 :   OUT   std_logic;
        m00_axis_I_tdata                  :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m01_axis_I_tvalid                 :   OUT   std_logic;
        m01_axis_I_tdata                  :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
        );
END awgn_channel_src_AWGN_Channel;


ARCHITECTURE rtl OF awgn_channel_src_AWGN_Channel IS

  -- Component Declarations
  COMPONENT awgn_channel_src_To_SSR_I
    PORT( data_wide                       :   IN    std_logic_vector(47 DOWNTO 0);  -- ufix48
          data_ssr                        :   OUT   vector_of_std_logic_vector3(0 TO 15)  -- ufix3 [16]
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_To_SSR_Q
    PORT( data_wide                       :   IN    std_logic_vector(47 DOWNTO 0);  -- ufix48
          data_ssr                        :   OUT   vector_of_std_logic_vector3(0 TO 15)  -- ufix3 [16]
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_AWGN
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          noise_std                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          reset_1                         :   IN    std_logic;
          Out1_re                         :   OUT   vector_of_std_logic_vector15(0 TO 15);  -- sfix15_En11 [16]
          Out1_im                         :   OUT   vector_of_std_logic_vector15(0 TO 15)  -- sfix15_En11 [16]
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_From_SSR_Q
    PORT( data_ssr                        :   IN    vector_of_std_logic_vector16(0 TO 7);  -- sfix16_En11 [8]
          data_wide                       :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_From_SSR_Q1
    PORT( data_ssr                        :   IN    vector_of_std_logic_vector16(0 TO 7);  -- sfix16_En11 [8]
          data_wide                       :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_From_SSR_I
    PORT( data_ssr                        :   IN    vector_of_std_logic_vector16(0 TO 7);  -- sfix16_En11 [8]
          data_wide                       :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_From_SSR_I1
    PORT( data_ssr                        :   IN    vector_of_std_logic_vector16(0 TO 7);  -- sfix16_En11 [8]
          data_wide                       :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : awgn_channel_src_To_SSR_I
    USE ENTITY work.awgn_channel_src_To_SSR_I(rtl);

  FOR ALL : awgn_channel_src_To_SSR_Q
    USE ENTITY work.awgn_channel_src_To_SSR_Q(rtl);

  FOR ALL : awgn_channel_src_AWGN
    USE ENTITY work.awgn_channel_src_AWGN(rtl);

  FOR ALL : awgn_channel_src_From_SSR_Q
    USE ENTITY work.awgn_channel_src_From_SSR_Q(rtl);

  FOR ALL : awgn_channel_src_From_SSR_Q1
    USE ENTITY work.awgn_channel_src_From_SSR_Q1(rtl);

  FOR ALL : awgn_channel_src_From_SSR_I
    USE ENTITY work.awgn_channel_src_From_SSR_I(rtl);

  FOR ALL : awgn_channel_src_From_SSR_I1
    USE ENTITY work.awgn_channel_src_From_SSR_I1(rtl);

  -- Signals
  SIGNAL To_SSR_I_out1                    : vector_of_std_logic_vector3(0 TO 15);  -- ufix3 [16]
  SIGNAL To_SSR_I_out1_unsigned           : vector_of_unsigned3(0 TO 15);  -- ufix3 [16]
  SIGNAL To_SSR_Q_out1                    : vector_of_std_logic_vector3(0 TO 15);  -- ufix3 [16]
  SIGNAL To_SSR_Q_out1_unsigned           : vector_of_unsigned3(0 TO 15);  -- ufix3 [16]
  SIGNAL Data_Type_Conversion_out1_re     : vector_of_signed3(0 TO 15);  -- sfix3 [16]
  SIGNAL Data_Type_Conversion_out1_im     : vector_of_signed3(0 TO 15);  -- sfix3 [16]
  SIGNAL aximm_awgn_reset_unsigned        : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Cast_To_Boolean_out1             : std_logic;
  SIGNAL AWGN_out1_re                     : vector_of_std_logic_vector15(0 TO 15);  -- ufix15 [16]
  SIGNAL AWGN_out1_im                     : vector_of_std_logic_vector15(0 TO 15);  -- ufix15 [16]
  SIGNAL AWGN_out1_re_signed              : vector_of_signed15(0 TO 15);  -- sfix15_En11 [16]
  SIGNAL AWGN_out1_im_signed              : vector_of_signed15(0 TO 15);  -- sfix15_En11 [16]
  SIGNAL Add_add_cast                     : vector_of_signed16(0 TO 15);  -- sfix16_En11 [16]
  SIGNAL Add_add_cast_1                   : vector_of_signed16(0 TO 15);  -- sfix16_En11 [16]
  SIGNAL Add_add_cast_2                   : vector_of_signed16(0 TO 15);  -- sfix16_En11 [16]
  SIGNAL Add_add_cast_3                   : vector_of_signed16(0 TO 15);  -- sfix16_En11 [16]
  SIGNAL Add_out1_re                      : vector_of_signed16(0 TO 15);  -- sfix16_En11 [16]
  SIGNAL Add_out1_im                      : vector_of_signed16(0 TO 15);  -- sfix16_En11 [16]
  SIGNAL Demux1_out1                      : vector_of_signed16(0 TO 7);  -- sfix16_En11 [8]
  SIGNAL Demux1_out1_1                    : vector_of_std_logic_vector16(0 TO 7);  -- ufix16 [8]
  SIGNAL y                                : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL Demux1_out2                      : vector_of_signed16(0 TO 7);  -- sfix16_En11 [8]
  SIGNAL Demux1_out2_1                    : vector_of_std_logic_vector16(0 TO 7);  -- ufix16 [8]
  SIGNAL y_1                              : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL Demux_out1                       : vector_of_signed16(0 TO 7);  -- sfix16_En11 [8]
  SIGNAL Demux_out1_1                     : vector_of_std_logic_vector16(0 TO 7);  -- ufix16 [8]
  SIGNAL y_2                              : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL Demux_out2                       : vector_of_signed16(0 TO 7);  -- sfix16_En11 [8]
  SIGNAL Demux_out2_1                     : vector_of_std_logic_vector16(0 TO 7);  -- ufix16 [8]
  SIGNAL y_3                              : std_logic_vector(127 DOWNTO 0);  -- ufix128

BEGIN
  u_To_SSR_I : awgn_channel_src_To_SSR_I
    PORT MAP( data_wide => s_axis_I_tdata,  -- ufix48
              data_ssr => To_SSR_I_out1  -- ufix3 [16]
              );

  u_To_SSR_Q : awgn_channel_src_To_SSR_Q
    PORT MAP( data_wide => s_axis_Q_tdata,  -- ufix48
              data_ssr => To_SSR_Q_out1  -- ufix3 [16]
              );

  u_AWGN : awgn_channel_src_AWGN
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => clk_enable,
              noise_std => aximm_noise_std,  -- ufix32_En30
              reset_1 => Cast_To_Boolean_out1,
              Out1_re => AWGN_out1_re,  -- sfix15_En11 [16]
              Out1_im => AWGN_out1_im  -- sfix15_En11 [16]
              );

  u_From_SSR_Q : awgn_channel_src_From_SSR_Q
    PORT MAP( data_ssr => Demux1_out1_1,  -- sfix16_En11 [8]
              data_wide => y  -- ufix128
              );

  u_From_SSR_Q1 : awgn_channel_src_From_SSR_Q1
    PORT MAP( data_ssr => Demux1_out2_1,  -- sfix16_En11 [8]
              data_wide => y_1  -- ufix128
              );

  u_From_SSR_I : awgn_channel_src_From_SSR_I
    PORT MAP( data_ssr => Demux_out1_1,  -- sfix16_En11 [8]
              data_wide => y_2  -- ufix128
              );

  u_From_SSR_I1 : awgn_channel_src_From_SSR_I1
    PORT MAP( data_ssr => Demux_out2_1,  -- sfix16_En11 [8]
              data_wide => y_3  -- ufix128
              );

  outputgen7: FOR k IN 0 TO 15 GENERATE
    To_SSR_I_out1_unsigned(k) <= unsigned(To_SSR_I_out1(k));
  END GENERATE;

  outputgen6: FOR k IN 0 TO 15 GENERATE
    To_SSR_Q_out1_unsigned(k) <= unsigned(To_SSR_Q_out1(k));
  END GENERATE;


  Data_Type_Conversion_out1_im_gen: FOR ii IN 0 TO 15 GENERATE
    Data_Type_Conversion_out1_re(ii) <= signed(To_SSR_I_out1_unsigned(ii));
    Data_Type_Conversion_out1_im(ii) <= signed(To_SSR_Q_out1_unsigned(ii));
  END GENERATE Data_Type_Conversion_out1_im_gen;


  aximm_awgn_reset_unsigned <= unsigned(aximm_awgn_reset);

  
  Cast_To_Boolean_out1 <= '1' WHEN aximm_awgn_reset_unsigned /= to_unsigned(0, 32) ELSE
      '0';

  outputgen5: FOR k IN 0 TO 15 GENERATE
    AWGN_out1_re_signed(k) <= signed(AWGN_out1_re(k));
  END GENERATE;

  outputgen4: FOR k IN 0 TO 15 GENERATE
    AWGN_out1_im_signed(k) <= signed(AWGN_out1_im(k));
  END GENERATE;


  Add_out1_im_gen: FOR t_0 IN 0 TO 15 GENERATE
    Add_add_cast(t_0) <= resize(Data_Type_Conversion_out1_re(t_0) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 16);
    Add_add_cast_1(t_0) <= resize(AWGN_out1_re_signed(t_0), 16);
    Add_out1_re(t_0) <= Add_add_cast(t_0) + Add_add_cast_1(t_0);
    Add_add_cast_2(t_0) <= resize(Data_Type_Conversion_out1_im(t_0) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 16);
    Add_add_cast_3(t_0) <= resize(AWGN_out1_im_signed(t_0), 16);
    Add_out1_im(t_0) <= Add_add_cast_2(t_0) + Add_add_cast_3(t_0);
  END GENERATE Add_out1_im_gen;


  Demux1_out1(0) <= Add_out1_im(0);
  Demux1_out1(1) <= Add_out1_im(1);
  Demux1_out1(2) <= Add_out1_im(2);
  Demux1_out1(3) <= Add_out1_im(3);
  Demux1_out1(4) <= Add_out1_im(4);
  Demux1_out1(5) <= Add_out1_im(5);
  Demux1_out1(6) <= Add_out1_im(6);
  Demux1_out1(7) <= Add_out1_im(7);

  outputgen3: FOR k IN 0 TO 7 GENERATE
    Demux1_out1_1(k) <= std_logic_vector(Demux1_out1(k));
  END GENERATE;

  Demux1_out2(0) <= Add_out1_im(8);
  Demux1_out2(1) <= Add_out1_im(9);
  Demux1_out2(2) <= Add_out1_im(10);
  Demux1_out2(3) <= Add_out1_im(11);
  Demux1_out2(4) <= Add_out1_im(12);
  Demux1_out2(5) <= Add_out1_im(13);
  Demux1_out2(6) <= Add_out1_im(14);
  Demux1_out2(7) <= Add_out1_im(15);

  outputgen2: FOR k IN 0 TO 7 GENERATE
    Demux1_out2_1(k) <= std_logic_vector(Demux1_out2(k));
  END GENERATE;

  Demux_out1(0) <= Add_out1_re(0);
  Demux_out1(1) <= Add_out1_re(1);
  Demux_out1(2) <= Add_out1_re(2);
  Demux_out1(3) <= Add_out1_re(3);
  Demux_out1(4) <= Add_out1_re(4);
  Demux_out1(5) <= Add_out1_re(5);
  Demux_out1(6) <= Add_out1_re(6);
  Demux_out1(7) <= Add_out1_re(7);

  outputgen1: FOR k IN 0 TO 7 GENERATE
    Demux_out1_1(k) <= std_logic_vector(Demux_out1(k));
  END GENERATE;

  Demux_out2(0) <= Add_out1_re(8);
  Demux_out2(1) <= Add_out1_re(9);
  Demux_out2(2) <= Add_out1_re(10);
  Demux_out2(3) <= Add_out1_re(11);
  Demux_out2(4) <= Add_out1_re(12);
  Demux_out2(5) <= Add_out1_re(13);
  Demux_out2(6) <= Add_out1_re(14);
  Demux_out2(7) <= Add_out1_re(15);

  outputgen: FOR k IN 0 TO 7 GENERATE
    Demux_out2_1(k) <= std_logic_vector(Demux_out2(k));
  END GENERATE;

  ce_out <= clk_enable;

  m00_axis_Q_tvalid <= s_axis_Q_tvalid;

  m00_axis_Q_tdata <= y;

  m01_axis_Q_tvalid <= s_axis_Q_tvalid;

  m01_axis_Q_tdata <= y_1;

  m00_axis_I_tvalid <= s_axis_I_tvalid;

  m00_axis_I_tdata <= y_2;

  m01_axis_I_tvalid <= s_axis_I_tvalid;

  m01_axis_I_tdata <= y_3;

END rtl;

