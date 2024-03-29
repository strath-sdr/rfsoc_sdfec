-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example_v2\ber.vhd
-- Created: 2023-01-16 12:06:09
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
-- Module: ber
-- Source Path: ber
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ber IS
  PORT( IPCORE_CLK                        :   IN    std_logic;  -- ufix1
        IPCORE_RESETN                     :   IN    std_logic;  -- ufix1
        s_axis_decoded_tvalid             :   IN    std_logic;  -- ufix1
        s_axis_decoded_tdata              :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8
        s_axis_orig_tvalid                :   IN    std_logic;  -- ufix1
        s_axis_orig_tdata                 :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8
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
        ber_intr                          :   OUT   std_logic;  -- ufix1
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic  -- ufix1
        );
END ber;


ARCHITECTURE rtl OF ber IS

  -- Component Declarations
  COMPONENT ber_reset_sync
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset_in                        :   IN    std_logic;  -- ufix1
          reset_out                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ber_axi_lite
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
          read_aximm_bit_error            :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          read_aximm_bit_count            :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          read_aximm_fifo_num             :   IN    std_logic_vector(16 DOWNTO 0);  -- ufix17
          AXI4_Lite_AWREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_WREADY                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_BRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_BVALID                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_ARREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_RDATA                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_RRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_RVALID                :   OUT   std_logic;  -- ufix1
          write_axi_enable                :   OUT   std_logic;  -- ufix1
          write_aximm_bit_count_reset     :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_aximm_length              :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          reset_internal                  :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT ber_dut
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          dut_enable                      :   IN    std_logic;  -- ufix1
          aximm_bit_count_reset           :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          aximm_length                    :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          s_axis_decoded_tvalid           :   IN    std_logic;  -- ufix1
          s_axis_decoded_tdata            :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8
          s_axis_orig_tvalid              :   IN    std_logic;  -- ufix1
          s_axis_orig_tdata               :   IN    std_logic_vector(7 DOWNTO 0);  -- ufix8
          ce_out                          :   OUT   std_logic;  -- ufix1
          aximm_bit_error                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          aximm_bit_count                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          aximm_fifo_num                  :   OUT   std_logic_vector(16 DOWNTO 0);  -- ufix17
          ber_intr                        :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ber_reset_sync
    USE ENTITY work.ber_reset_sync(rtl);

  FOR ALL : ber_axi_lite
    USE ENTITY work.ber_axi_lite(rtl);

  FOR ALL : ber_dut
    USE ENTITY work.ber_dut(rtl);

  -- Signals
  SIGNAL reset                            : std_logic;
  SIGNAL ip_timestamp                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reset_cm                         : std_logic;  -- ufix1
  SIGNAL reset_internal                   : std_logic;  -- ufix1
  SIGNAL reset_before_sync                : std_logic;  -- ufix1
  SIGNAL aximm_bit_error_sig              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL aximm_bit_count_sig              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL aximm_fifo_num_sig               : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL AXI4_Lite_BRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL AXI4_Lite_RDATA_tmp              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_RRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL write_axi_enable                 : std_logic;  -- ufix1
  SIGNAL write_aximm_bit_count_reset      : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_aximm_length               : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL ber_intr_sig                     : std_logic;  -- ufix1

BEGIN
  u_ber_reset_sync_inst : ber_reset_sync
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset_in => reset_before_sync,  -- ufix1
              reset_out => reset
              );

  u_ber_axi_lite_inst : ber_axi_lite
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
              read_aximm_bit_error => aximm_bit_error_sig,  -- ufix32
              read_aximm_bit_count => aximm_bit_count_sig,  -- ufix32
              read_aximm_fifo_num => aximm_fifo_num_sig,  -- ufix17
              AXI4_Lite_AWREADY => AXI4_Lite_AWREADY,  -- ufix1
              AXI4_Lite_WREADY => AXI4_Lite_WREADY,  -- ufix1
              AXI4_Lite_BRESP => AXI4_Lite_BRESP_tmp,  -- ufix2
              AXI4_Lite_BVALID => AXI4_Lite_BVALID,  -- ufix1
              AXI4_Lite_ARREADY => AXI4_Lite_ARREADY,  -- ufix1
              AXI4_Lite_RDATA => AXI4_Lite_RDATA_tmp,  -- ufix32
              AXI4_Lite_RRESP => AXI4_Lite_RRESP_tmp,  -- ufix2
              AXI4_Lite_RVALID => AXI4_Lite_RVALID,  -- ufix1
              write_axi_enable => write_axi_enable,  -- ufix1
              write_aximm_bit_count_reset => write_aximm_bit_count_reset,  -- ufix32
              write_aximm_length => write_aximm_length,  -- ufix32
              reset_internal => reset_internal  -- ufix1
              );

  u_ber_dut_inst : ber_dut
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              dut_enable => write_axi_enable,  -- ufix1
              aximm_bit_count_reset => write_aximm_bit_count_reset,  -- ufix32
              aximm_length => write_aximm_length,  -- ufix32
              s_axis_decoded_tvalid => s_axis_decoded_tvalid,  -- ufix1
              s_axis_decoded_tdata => s_axis_decoded_tdata,  -- ufix8
              s_axis_orig_tvalid => s_axis_orig_tvalid,  -- ufix1
              s_axis_orig_tdata => s_axis_orig_tdata,  -- ufix8
              ce_out => ce_out_sig,  -- ufix1
              aximm_bit_error => aximm_bit_error_sig,  -- ufix32
              aximm_bit_count => aximm_bit_count_sig,  -- ufix32
              aximm_fifo_num => aximm_fifo_num_sig,  -- ufix17
              ber_intr => ber_intr_sig  -- ufix1
              );

  ip_timestamp <= unsigned'(X"8928EEF6");

  reset_cm <=  NOT IPCORE_RESETN;

  reset_before_sync <= reset_cm OR reset_internal;

  ber_intr <= ber_intr_sig;

  AXI4_Lite_BRESP <= AXI4_Lite_BRESP_tmp;

  AXI4_Lite_RDATA <= AXI4_Lite_RDATA_tmp;

  AXI4_Lite_RRESP <= AXI4_Lite_RRESP_tmp;

END rtl;

