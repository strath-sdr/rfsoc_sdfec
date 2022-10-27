-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bit\hdlsrc\fec_ber_hw_V2\encoder_control.vhd
-- Created: 2022-10-27 12:29:37
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
-- Module: encoder_control
-- Source Path: encoder_control
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY encoder_control IS
  PORT( IPCORE_CLK                        :   IN    std_logic;  -- ufix1
        IPCORE_RESETN                     :   IN    std_logic;  -- ufix1
        s_axis_tvalid                     :   IN    std_logic;  -- ufix1
        s_axis_tdata                      :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        s_axis_status_tvalid              :   IN    std_logic;  -- ufix1
        s_axis_status_tdata               :   IN    std_logic;  -- ufix1
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
        m_axis_ctrl_tvalid                :   OUT   std_logic;  -- ufix1
        m_axis_ctrl_tdata                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        m_axis_ctrl_tlast                 :   OUT   std_logic;  -- ufix1
        m_axis_tvalid                     :   OUT   std_logic;  -- ufix1
        m_axis_tdata                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        s_axis_status_tready              :   OUT   std_logic;  -- ufix1
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic  -- ufix1
        );
END encoder_control;


ARCHITECTURE rtl OF encoder_control IS

  -- Component Declarations
  COMPONENT encoder_control_reset_sync
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset_in                        :   IN    std_logic;  -- ufix1
          reset_out                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT encoder_control_axi_lite
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
          write_aximm_ctrl_word           :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_aximm_length              :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_aximm_load                :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          reset_internal                  :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT encoder_control_dut
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          dut_enable                      :   IN    std_logic;  -- ufix1
          aximm_ctrl_word                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          aximm_length                    :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          aximm_load                      :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          s_axis_tvalid                   :   IN    std_logic;  -- ufix1
          s_axis_tdata                    :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          s_axis_status_tvalid            :   IN    std_logic;  -- ufix1
          s_axis_status_tdata             :   IN    std_logic;  -- ufix1
          ce_out                          :   OUT   std_logic;  -- ufix1
          m_axis_ctrl_tvalid              :   OUT   std_logic;  -- ufix1
          m_axis_ctrl_tdata               :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          m_axis_ctrl_tlast               :   OUT   std_logic;  -- ufix1
          m_axis_tvalid                   :   OUT   std_logic;  -- ufix1
          m_axis_tdata                    :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          s_axis_status_tready            :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : encoder_control_reset_sync
    USE ENTITY work.encoder_control_reset_sync(rtl);

  FOR ALL : encoder_control_axi_lite
    USE ENTITY work.encoder_control_axi_lite(rtl);

  FOR ALL : encoder_control_dut
    USE ENTITY work.encoder_control_dut(rtl);

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
  SIGNAL write_aximm_ctrl_word            : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_aximm_length               : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_aximm_load                 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL m_axis_ctrl_tvalid_sig           : std_logic;  -- ufix1
  SIGNAL m_axis_ctrl_tdata_sig            : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL m_axis_ctrl_tlast_sig            : std_logic;  -- ufix1
  SIGNAL m_axis_tvalid_sig                : std_logic;  -- ufix1
  SIGNAL m_axis_tdata_sig                 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL s_axis_status_tready_sig         : std_logic;  -- ufix1

BEGIN
  u_encoder_control_reset_sync_inst : encoder_control_reset_sync
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset_in => reset_before_sync,  -- ufix1
              reset_out => reset
              );

  u_encoder_control_axi_lite_inst : encoder_control_axi_lite
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
              write_aximm_ctrl_word => write_aximm_ctrl_word,  -- ufix32
              write_aximm_length => write_aximm_length,  -- ufix32
              write_aximm_load => write_aximm_load,  -- ufix32
              reset_internal => reset_internal  -- ufix1
              );

  u_encoder_control_dut_inst : encoder_control_dut
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              dut_enable => write_axi_enable,  -- ufix1
              aximm_ctrl_word => write_aximm_ctrl_word,  -- ufix32
              aximm_length => write_aximm_length,  -- ufix32
              aximm_load => write_aximm_load,  -- ufix32
              s_axis_tvalid => s_axis_tvalid,  -- ufix1
              s_axis_tdata => s_axis_tdata,  -- ufix32
              s_axis_status_tvalid => s_axis_status_tvalid,  -- ufix1
              s_axis_status_tdata => s_axis_status_tdata,  -- ufix1
              ce_out => ce_out_sig,  -- ufix1
              m_axis_ctrl_tvalid => m_axis_ctrl_tvalid_sig,  -- ufix1
              m_axis_ctrl_tdata => m_axis_ctrl_tdata_sig,  -- ufix32
              m_axis_ctrl_tlast => m_axis_ctrl_tlast_sig,  -- ufix1
              m_axis_tvalid => m_axis_tvalid_sig,  -- ufix1
              m_axis_tdata => m_axis_tdata_sig,  -- ufix32
              s_axis_status_tready => s_axis_status_tready_sig  -- ufix1
              );

  ip_timestamp <= unsigned'(X"83BE0FFD");

  reset_cm <=  NOT IPCORE_RESETN;

  reset_before_sync <= reset_cm OR reset_internal;

  m_axis_ctrl_tvalid <= m_axis_ctrl_tvalid_sig;

  m_axis_ctrl_tdata <= m_axis_ctrl_tdata_sig;

  m_axis_ctrl_tlast <= m_axis_ctrl_tlast_sig;

  m_axis_tvalid <= m_axis_tvalid_sig;

  m_axis_tdata <= m_axis_tdata_sig;

  s_axis_status_tready <= s_axis_status_tready_sig;

  AXI4_Lite_BRESP <= AXI4_Lite_BRESP_tmp;

  AXI4_Lite_RDATA <= AXI4_Lite_RDATA_tmp;

  AXI4_Lite_RRESP <= AXI4_Lite_RRESP_tmp;

END rtl;

