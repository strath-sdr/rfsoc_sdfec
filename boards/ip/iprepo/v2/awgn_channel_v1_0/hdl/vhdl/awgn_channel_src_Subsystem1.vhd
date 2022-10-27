-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\awgn_channel_src_Subsystem1.vhd
-- Created: 2022-10-27 12:50:15
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: awgn_channel_src_Subsystem1
-- Source Path: fec_ber_hw_V2/AWGN Channel/AWGN/Subsystem1
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.awgn_channel_src_AWGN_Channel_pkg.ALL;

ENTITY awgn_channel_src_Subsystem1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        noise_std                         :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
        reset_1                           :   IN    std_logic;
        Out1_re                           :   OUT   vector_of_std_logic_vector15(0 TO 7);  -- sfix15_En11 [8]
        Out1_im                           :   OUT   vector_of_std_logic_vector15(0 TO 7)  -- sfix15_En11 [8]
        );
END awgn_channel_src_Subsystem1;


ARCHITECTURE rtl OF awgn_channel_src_Subsystem1 IS

  -- Component Declarations
  COMPONENT awgn_channel_src_AWGN_Generator_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          noise_std                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          reset_1                         :   IN    std_logic;
          awgn_re                         :   OUT   std_logic_vector(14 DOWNTO 0);  -- sfix15_En11
          awgn_im                         :   OUT   std_logic_vector(14 DOWNTO 0)  -- sfix15_En11
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_AWGN_Generator1_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          noise_std                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          reset_1                         :   IN    std_logic;
          awgn_re                         :   OUT   std_logic_vector(14 DOWNTO 0);  -- sfix15_En11
          awgn_im                         :   OUT   std_logic_vector(14 DOWNTO 0)  -- sfix15_En11
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_AWGN_Generator2_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          noise_std                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          reset_1                         :   IN    std_logic;
          awgn_re                         :   OUT   std_logic_vector(14 DOWNTO 0);  -- sfix15_En11
          awgn_im                         :   OUT   std_logic_vector(14 DOWNTO 0)  -- sfix15_En11
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_AWGN_Generator3_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          noise_std                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          reset_1                         :   IN    std_logic;
          awgn_re                         :   OUT   std_logic_vector(14 DOWNTO 0);  -- sfix15_En11
          awgn_im                         :   OUT   std_logic_vector(14 DOWNTO 0)  -- sfix15_En11
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_AWGN_Generator4_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          noise_std                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          reset_1                         :   IN    std_logic;
          awgn_re                         :   OUT   std_logic_vector(14 DOWNTO 0);  -- sfix15_En11
          awgn_im                         :   OUT   std_logic_vector(14 DOWNTO 0)  -- sfix15_En11
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_AWGN_Generator5_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          noise_std                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          reset_1                         :   IN    std_logic;
          awgn_re                         :   OUT   std_logic_vector(14 DOWNTO 0);  -- sfix15_En11
          awgn_im                         :   OUT   std_logic_vector(14 DOWNTO 0)  -- sfix15_En11
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_AWGN_Generator6_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          noise_std                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          reset_1                         :   IN    std_logic;
          awgn_re                         :   OUT   std_logic_vector(14 DOWNTO 0);  -- sfix15_En11
          awgn_im                         :   OUT   std_logic_vector(14 DOWNTO 0)  -- sfix15_En11
          );
  END COMPONENT;

  COMPONENT awgn_channel_src_AWGN_Generator7_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          noise_std                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          reset_1                         :   IN    std_logic;
          awgn_re                         :   OUT   std_logic_vector(14 DOWNTO 0);  -- sfix15_En11
          awgn_im                         :   OUT   std_logic_vector(14 DOWNTO 0)  -- sfix15_En11
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : awgn_channel_src_AWGN_Generator_block
    USE ENTITY work.awgn_channel_src_AWGN_Generator_block(rtl);

  FOR ALL : awgn_channel_src_AWGN_Generator1_block
    USE ENTITY work.awgn_channel_src_AWGN_Generator1_block(rtl);

  FOR ALL : awgn_channel_src_AWGN_Generator2_block
    USE ENTITY work.awgn_channel_src_AWGN_Generator2_block(rtl);

  FOR ALL : awgn_channel_src_AWGN_Generator3_block
    USE ENTITY work.awgn_channel_src_AWGN_Generator3_block(rtl);

  FOR ALL : awgn_channel_src_AWGN_Generator4_block
    USE ENTITY work.awgn_channel_src_AWGN_Generator4_block(rtl);

  FOR ALL : awgn_channel_src_AWGN_Generator5_block
    USE ENTITY work.awgn_channel_src_AWGN_Generator5_block(rtl);

  FOR ALL : awgn_channel_src_AWGN_Generator6_block
    USE ENTITY work.awgn_channel_src_AWGN_Generator6_block(rtl);

  FOR ALL : awgn_channel_src_AWGN_Generator7_block
    USE ENTITY work.awgn_channel_src_AWGN_Generator7_block(rtl);

  -- Signals
  SIGNAL Mux_out1_re                      : vector_of_std_logic_vector15(0 TO 7);  -- ufix15 [8]
  SIGNAL Mux_out1_im                      : vector_of_std_logic_vector15(0 TO 7);  -- ufix15 [8]

BEGIN
  u_AWGN_Generator : awgn_channel_src_AWGN_Generator_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              noise_std => noise_std,  -- ufix32_En30
              reset_1 => reset_1,
              awgn_re => Mux_out1_re(0),  -- sfix15_En11
              awgn_im => Mux_out1_im(0)  -- sfix15_En11
              );

  u_AWGN_Generator1 : awgn_channel_src_AWGN_Generator1_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              noise_std => noise_std,  -- ufix32_En30
              reset_1 => reset_1,
              awgn_re => Mux_out1_re(1),  -- sfix15_En11
              awgn_im => Mux_out1_im(1)  -- sfix15_En11
              );

  u_AWGN_Generator2 : awgn_channel_src_AWGN_Generator2_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              noise_std => noise_std,  -- ufix32_En30
              reset_1 => reset_1,
              awgn_re => Mux_out1_re(2),  -- sfix15_En11
              awgn_im => Mux_out1_im(2)  -- sfix15_En11
              );

  u_AWGN_Generator3 : awgn_channel_src_AWGN_Generator3_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              noise_std => noise_std,  -- ufix32_En30
              reset_1 => reset_1,
              awgn_re => Mux_out1_re(3),  -- sfix15_En11
              awgn_im => Mux_out1_im(3)  -- sfix15_En11
              );

  u_AWGN_Generator4 : awgn_channel_src_AWGN_Generator4_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              noise_std => noise_std,  -- ufix32_En30
              reset_1 => reset_1,
              awgn_re => Mux_out1_re(4),  -- sfix15_En11
              awgn_im => Mux_out1_im(4)  -- sfix15_En11
              );

  u_AWGN_Generator5 : awgn_channel_src_AWGN_Generator5_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              noise_std => noise_std,  -- ufix32_En30
              reset_1 => reset_1,
              awgn_re => Mux_out1_re(5),  -- sfix15_En11
              awgn_im => Mux_out1_im(5)  -- sfix15_En11
              );

  u_AWGN_Generator6 : awgn_channel_src_AWGN_Generator6_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              noise_std => noise_std,  -- ufix32_En30
              reset_1 => reset_1,
              awgn_re => Mux_out1_re(6),  -- sfix15_En11
              awgn_im => Mux_out1_im(6)  -- sfix15_En11
              );

  u_AWGN_Generator7 : awgn_channel_src_AWGN_Generator7_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              noise_std => noise_std,  -- ufix32_En30
              reset_1 => reset_1,
              awgn_re => Mux_out1_re(7),  -- sfix15_En11
              awgn_im => Mux_out1_im(7)  -- sfix15_En11
              );



  Out1_re <= Mux_out1_re;

  Out1_im <= Mux_out1_im;

END rtl;

