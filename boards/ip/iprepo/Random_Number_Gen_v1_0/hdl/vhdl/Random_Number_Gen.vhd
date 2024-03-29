-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example_v2\Random_Number_Gen.vhd
-- Created: 2023-01-13 11:55:54
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
-- Module: Random_Number_Gen
-- Source Path: Random_Number_Gen
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Random_Number_Gen IS
  PORT( IPCORE_CLK                        :   IN    std_logic;  -- ufix1
        IPCORE_RESETN                     :   IN    std_logic;  -- ufix1
        m00_axis_tready                   :   IN    std_logic;  -- ufix1
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
        m00_axis_tvalid                   :   OUT   std_logic;  -- ufix1
        m00_axis_tdata                    :   OUT   std_logic_vector(7 DOWNTO 0);  -- ufix8
        m01_axis_tvalid                   :   OUT   std_logic;  -- ufix1
        m01_axis_tdata                    :   OUT   std_logic_vector(7 DOWNTO 0);  -- ufix8
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic  -- ufix1
        );
END Random_Number_Gen;


ARCHITECTURE rtl OF Random_Number_Gen IS

  -- Component Declarations
  COMPONENT Random_Number_Gen_reset_sync
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset_in                        :   IN    std_logic;  -- ufix1
          reset_out                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Random_Number_Gen_axi_lite
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
          write_aximm_enable              :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_aximm_bits                :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_aximm_reset               :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          reset_internal                  :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT Random_Number_Gen_dut
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          dut_enable                      :   IN    std_logic;  -- ufix1
          aximm_enable                    :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          aximm_bits                      :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          aximm_reset                     :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          m00_axis_tready                 :   IN    std_logic;  -- ufix1
          ce_out                          :   OUT   std_logic;  -- ufix1
          m00_axis_tvalid                 :   OUT   std_logic;  -- ufix1
          m00_axis_tdata                  :   OUT   std_logic_vector(7 DOWNTO 0);  -- ufix8
          m01_axis_tvalid                 :   OUT   std_logic;  -- ufix1
          m01_axis_tdata                  :   OUT   std_logic_vector(7 DOWNTO 0)  -- ufix8
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Random_Number_Gen_reset_sync
    USE ENTITY work.Random_Number_Gen_reset_sync(rtl);

  FOR ALL : Random_Number_Gen_axi_lite
    USE ENTITY work.Random_Number_Gen_axi_lite(rtl);

  FOR ALL : Random_Number_Gen_dut
    USE ENTITY work.Random_Number_Gen_dut(rtl);

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
  SIGNAL write_aximm_enable               : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_aximm_bits                 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_aximm_reset                : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL m00_axis_tvalid_sig              : std_logic;  -- ufix1
  SIGNAL m00_axis_tdata_sig               : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL m01_axis_tvalid_sig              : std_logic;  -- ufix1
  SIGNAL m01_axis_tdata_sig               : std_logic_vector(7 DOWNTO 0);  -- ufix8

BEGIN
  u_Random_Number_Gen_reset_sync_inst : Random_Number_Gen_reset_sync
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset_in => reset_before_sync,  -- ufix1
              reset_out => reset
              );

  u_Random_Number_Gen_axi_lite_inst : Random_Number_Gen_axi_lite
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
              write_aximm_enable => write_aximm_enable,  -- ufix32
              write_aximm_bits => write_aximm_bits,  -- ufix32
              write_aximm_reset => write_aximm_reset,  -- ufix32
              reset_internal => reset_internal  -- ufix1
              );

  u_Random_Number_Gen_dut_inst : Random_Number_Gen_dut
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              dut_enable => write_axi_enable,  -- ufix1
              aximm_enable => write_aximm_enable,  -- ufix32
              aximm_bits => write_aximm_bits,  -- ufix32
              aximm_reset => write_aximm_reset,  -- ufix32
              m00_axis_tready => m00_axis_tready,  -- ufix1
              ce_out => ce_out_sig,  -- ufix1
              m00_axis_tvalid => m00_axis_tvalid_sig,  -- ufix1
              m00_axis_tdata => m00_axis_tdata_sig,  -- ufix8
              m01_axis_tvalid => m01_axis_tvalid_sig,  -- ufix1
              m01_axis_tdata => m01_axis_tdata_sig  -- ufix8
              );

  ip_timestamp <= unsigned'(X"89287993");

  reset_cm <=  NOT IPCORE_RESETN;

  reset_before_sync <= reset_cm OR reset_internal;

  m00_axis_tvalid <= m00_axis_tvalid_sig;

  m00_axis_tdata <= m00_axis_tdata_sig;

  m01_axis_tvalid <= m01_axis_tvalid_sig;

  m01_axis_tdata <= m01_axis_tdata_sig;

  AXI4_Lite_BRESP <= AXI4_Lite_BRESP_tmp;

  AXI4_Lite_RDATA <= AXI4_Lite_RDATA_tmp;

  AXI4_Lite_RRESP <= AXI4_Lite_RRESP_tmp;

END rtl;

