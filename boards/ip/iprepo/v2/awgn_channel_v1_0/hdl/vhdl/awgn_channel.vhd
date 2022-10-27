-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\awgn_channel.vhd
-- Created: 2022-10-27 12:50:21
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: -1
-- Target subsystem base rate: -1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: awgn_channel
-- Source Path: awgn_channel
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY awgn_channel IS
  PORT( IPCORE_CLK                        :   IN    std_logic;  -- ufix1
        IPCORE_RESETN                     :   IN    std_logic;  -- ufix1
        s_axis_Q_tvalid                   :   IN    std_logic;  -- ufix1
        s_axis_Q_tdata                    :   IN    std_logic_vector(47 DOWNTO 0);  -- ufix48
        s_axis_I_tvalid                   :   IN    std_logic;  -- ufix1
        s_axis_I_tdata                    :   IN    std_logic_vector(47 DOWNTO 0);  -- ufix48
        AXI4_Lite_ACLK                    :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARESETN                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_AWADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_AWVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_WDATA                   :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_WSTRB                   :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        AXI4_Lite_WVALID                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_BREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_ARVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_RREADY                  :   IN    std_logic;  -- ufix1
        m00_axis_Q_tvalid                 :   OUT   std_logic;  -- ufix1
        m00_axis_Q_tdata                  :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m01_axis_Q_tvalid                 :   OUT   std_logic;  -- ufix1
        m01_axis_Q_tdata                  :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m00_axis_I_tvalid                 :   OUT   std_logic;  -- ufix1
        m00_axis_I_tdata                  :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m01_axis_I_tvalid                 :   OUT   std_logic;  -- ufix1
        m01_axis_I_tdata                  :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic  -- ufix1
        );
END awgn_channel;


ARCHITECTURE rtl OF awgn_channel IS

  -- Component Declarations
  COMPONENT awgn_channel_reset_sync
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset_in                        :   IN    std_logic;  -- ufix1
          reset_out                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT awgn_channel_axi_lite
    PORT( reset                           :   IN    std_logic;
          AXI4_Lite_ACLK                  :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARESETN               :   IN    std_logic;  -- ufix1
          AXI4_Lite_AWADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_AWVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_WDATA                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_WSTRB                 :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
          AXI4_Lite_WVALID                :   IN    std_logic;  -- ufix1
          AXI4_Lite_BREADY                :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_ARVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_RREADY                :   IN    std_logic;  -- ufix1
          read_ip_timestamp               :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_AWREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_WREADY                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_BRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_BVALID                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_ARREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_RDATA                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_RRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_RVALID                :   OUT   std_logic;  -- ufix1
          write_axi_enable                :   OUT   std_logic;  -- ufix1
          write_aximm_noise_std           :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          write_aximm_awgn_reset          :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          reset_internal                  :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT awgn_channel_dut
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          dut_enable                      :   IN    std_logic;  -- ufix1
          aximm_noise_std                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32_En30
          aximm_awgn_reset                :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          s_axis_Q_tvalid                 :   IN    std_logic;  -- ufix1
          s_axis_Q_tdata                  :   IN    std_logic_vector(47 DOWNTO 0);  -- ufix48
          s_axis_I_tvalid                 :   IN    std_logic;  -- ufix1
          s_axis_I_tdata                  :   IN    std_logic_vector(47 DOWNTO 0);  -- ufix48
          ce_out                          :   OUT   std_logic;  -- ufix1
          m00_axis_Q_tvalid               :   OUT   std_logic;  -- ufix1
          m00_axis_Q_tdata                :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          m01_axis_Q_tvalid               :   OUT   std_logic;  -- ufix1
          m01_axis_Q_tdata                :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          m00_axis_I_tvalid               :   OUT   std_logic;  -- ufix1
          m00_axis_I_tdata                :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          m01_axis_I_tvalid               :   OUT   std_logic;  -- ufix1
          m01_axis_I_tdata                :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : awgn_channel_reset_sync
    USE ENTITY work.awgn_channel_reset_sync(rtl);

  FOR ALL : awgn_channel_axi_lite
    USE ENTITY work.awgn_channel_axi_lite(rtl);

  FOR ALL : awgn_channel_dut
    USE ENTITY work.awgn_channel_dut(rtl);

  -- Signals
  SIGNAL reset                            : std_logic;
  SIGNAL ip_timestamp                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reset_cm                         : std_logic;  -- ufix1
  SIGNAL reset_internal                   : std_logic;  -- ufix1
  SIGNAL reset_before_sync                : std_logic;  -- ufix1
  SIGNAL AXI4_Lite_BRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL AXI4_Lite_RDATA_tmp              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_RRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL write_axi_enable                 : std_logic;  -- ufix1
  SIGNAL write_aximm_noise_std            : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_aximm_awgn_reset           : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL m00_axis_Q_tvalid_sig            : std_logic;  -- ufix1
  SIGNAL m00_axis_Q_tdata_sig             : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL m01_axis_Q_tvalid_sig            : std_logic;  -- ufix1
  SIGNAL m01_axis_Q_tdata_sig             : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL m00_axis_I_tvalid_sig            : std_logic;  -- ufix1
  SIGNAL m00_axis_I_tdata_sig             : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL m01_axis_I_tvalid_sig            : std_logic;  -- ufix1
  SIGNAL m01_axis_I_tdata_sig             : std_logic_vector(127 DOWNTO 0);  -- ufix128

BEGIN
  u_awgn_channel_reset_sync_inst : awgn_channel_reset_sync
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset_in => reset_before_sync,  -- ufix1
              reset_out => reset
              );

  u_awgn_channel_axi_lite_inst : awgn_channel_axi_lite
    PORT MAP( reset => reset,
              AXI4_Lite_ACLK => AXI4_Lite_ACLK,  -- ufix1
              AXI4_Lite_ARESETN => AXI4_Lite_ARESETN,  -- ufix1
              AXI4_Lite_AWADDR => AXI4_Lite_AWADDR,  -- ufix16
              AXI4_Lite_AWVALID => AXI4_Lite_AWVALID,  -- ufix1
              AXI4_Lite_WDATA => AXI4_Lite_WDATA,  -- ufix32
              AXI4_Lite_WSTRB => AXI4_Lite_WSTRB,  -- ufix4
              AXI4_Lite_WVALID => AXI4_Lite_WVALID,  -- ufix1
              AXI4_Lite_BREADY => AXI4_Lite_BREADY,  -- ufix1
              AXI4_Lite_ARADDR => AXI4_Lite_ARADDR,  -- ufix16
              AXI4_Lite_ARVALID => AXI4_Lite_ARVALID,  -- ufix1
              AXI4_Lite_RREADY => AXI4_Lite_RREADY,  -- ufix1
              read_ip_timestamp => std_logic_vector(ip_timestamp),  -- ufix32
              AXI4_Lite_AWREADY => AXI4_Lite_AWREADY,  -- ufix1
              AXI4_Lite_WREADY => AXI4_Lite_WREADY,  -- ufix1
              AXI4_Lite_BRESP => AXI4_Lite_BRESP_tmp,  -- ufix2
              AXI4_Lite_BVALID => AXI4_Lite_BVALID,  -- ufix1
              AXI4_Lite_ARREADY => AXI4_Lite_ARREADY,  -- ufix1
              AXI4_Lite_RDATA => AXI4_Lite_RDATA_tmp,  -- ufix32
              AXI4_Lite_RRESP => AXI4_Lite_RRESP_tmp,  -- ufix2
              AXI4_Lite_RVALID => AXI4_Lite_RVALID,  -- ufix1
              write_axi_enable => write_axi_enable,  -- ufix1
              write_aximm_noise_std => write_aximm_noise_std,  -- ufix32_En30
              write_aximm_awgn_reset => write_aximm_awgn_reset,  -- ufix32
              reset_internal => reset_internal  -- ufix1
              );

  u_awgn_channel_dut_inst : awgn_channel_dut
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              dut_enable => write_axi_enable,  -- ufix1
              aximm_noise_std => write_aximm_noise_std,  -- ufix32_En30
              aximm_awgn_reset => write_aximm_awgn_reset,  -- ufix32
              s_axis_Q_tvalid => s_axis_Q_tvalid,  -- ufix1
              s_axis_Q_tdata => s_axis_Q_tdata,  -- ufix48
              s_axis_I_tvalid => s_axis_I_tvalid,  -- ufix1
              s_axis_I_tdata => s_axis_I_tdata,  -- ufix48
              ce_out => ce_out_sig,  -- ufix1
              m00_axis_Q_tvalid => m00_axis_Q_tvalid_sig,  -- ufix1
              m00_axis_Q_tdata => m00_axis_Q_tdata_sig,  -- ufix128
              m01_axis_Q_tvalid => m01_axis_Q_tvalid_sig,  -- ufix1
              m01_axis_Q_tdata => m01_axis_Q_tdata_sig,  -- ufix128
              m00_axis_I_tvalid => m00_axis_I_tvalid_sig,  -- ufix1
              m00_axis_I_tdata => m00_axis_I_tdata_sig,  -- ufix128
              m01_axis_I_tvalid => m01_axis_I_tvalid_sig,  -- ufix1
              m01_axis_I_tdata => m01_axis_I_tdata_sig  -- ufix128
              );

  ip_timestamp <= unsigned'(X"83BE1012");

  reset_cm <=  NOT IPCORE_RESETN;

  reset_before_sync <= reset_cm OR reset_internal;

  m00_axis_Q_tvalid <= m00_axis_Q_tvalid_sig;

  m00_axis_Q_tdata <= m00_axis_Q_tdata_sig;

  m01_axis_Q_tvalid <= m01_axis_Q_tvalid_sig;

  m01_axis_Q_tdata <= m01_axis_Q_tdata_sig;

  m00_axis_I_tvalid <= m00_axis_I_tvalid_sig;

  m00_axis_I_tdata <= m00_axis_I_tdata_sig;

  m01_axis_I_tvalid <= m01_axis_I_tvalid_sig;

  m01_axis_I_tdata <= m01_axis_I_tdata_sig;

  AXI4_Lite_BRESP <= AXI4_Lite_BRESP_tmp;

  AXI4_Lite_RDATA <= AXI4_Lite_RDATA_tmp;

  AXI4_Lite_RRESP <= AXI4_Lite_RRESP_tmp;

END rtl;

