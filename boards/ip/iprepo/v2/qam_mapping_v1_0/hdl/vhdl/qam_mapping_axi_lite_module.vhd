-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\qam_mapping_axi_lite_module.vhd
-- Created: 2022-10-27 12:38:12
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: qam_mapping_axi_lite_module
-- Source Path: qam_mapping/qam_mapping_axi_lite/qam_mapping_axi_lite_module
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY qam_mapping_axi_lite_module IS
  PORT( clk                               :   IN    std_logic;
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
        data_read                         :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic;  -- ufix1
        data_write                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        addr_sel                          :   OUT   std_logic_vector(13 DOWNTO 0);  -- ufix14
        wr_enb                            :   OUT   std_logic;  -- ufix1
        rd_enb                            :   OUT   std_logic;  -- ufix1
        reset_internal                    :   OUT   std_logic  -- ufix1
        );
END qam_mapping_axi_lite_module;


ARCHITECTURE rtl OF qam_mapping_axi_lite_module IS

  -- Functions
  -- HDLCODER_TO_STDLOGIC 
  FUNCTION hdlcoder_to_stdlogic(arg: boolean) RETURN std_logic IS
  BEGIN
    IF arg THEN
      RETURN '1';
    ELSE
      RETURN '0';
    END IF;
  END FUNCTION;


  -- Signals
  SIGNAL reset                            : std_logic;
  SIGNAL enb                              : std_logic;
  SIGNAL const_1                          : std_logic;  -- ufix1
  SIGNAL axi_lite_wstate                  : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL axi_lite_rstate                  : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL axi_lite_wstate_next             : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL axi_lite_rstate_next             : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL rvalid_int                       : std_logic;  -- ufix1
  SIGNAL aw_transfer                      : std_logic;  -- ufix1
  SIGNAL w_transfer                       : std_logic;  -- ufix1
  SIGNAL ar_transfer                      : std_logic;  -- ufix1
  SIGNAL const_0_2                        : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL data_read_unsigned               : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_RDATA_tmp              : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_WDATA_unsigned         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL wdata                            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_AWADDR_unsigned        : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL waddr                            : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL waddr_sel                        : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL AXI4_Lite_ARADDR_unsigned        : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL raddr_sel                        : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL addr_sel_tmp                     : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL AXI4_Lite_WSTRB_unsigned         : unsigned(3 DOWNTO 0);  -- ufix4
  SIGNAL wstrb_reduce                     : std_logic;  -- ufix1
  SIGNAL w_transfer_and_wstrb             : std_logic;  -- ufix1
  SIGNAL wr_enb_1                         : std_logic;  -- ufix1
  SIGNAL strobe_addr                      : std_logic;  -- ufix1
  SIGNAL strobe_sel                       : std_logic;  -- ufix1
  SIGNAL const_zero                       : std_logic;  -- ufix1
  SIGNAL strobe_in                        : std_logic;  -- ufix1
  SIGNAL strobe_sw                        : std_logic;  -- ufix1
  SIGNAL soft_reset                       : std_logic;  -- ufix1

BEGIN
  const_1 <= '1';

  enb <= const_1;

  reset <=  NOT AXI4_Lite_ARESETN;

  axi_lite_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      axi_lite_wstate <= to_unsigned(16#00#, 8);
      axi_lite_rstate <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        axi_lite_wstate <= axi_lite_wstate_next;
        axi_lite_rstate <= axi_lite_rstate_next;
      END IF;
    END IF;
  END PROCESS axi_lite_process;

  axi_lite_output : PROCESS (AXI4_Lite_ARVALID, AXI4_Lite_AWVALID, AXI4_Lite_BREADY, AXI4_Lite_RREADY,
       AXI4_Lite_WVALID, axi_lite_rstate, axi_lite_wstate)
    VARIABLE out0 : std_logic;
    VARIABLE out1 : std_logic;
    VARIABLE awvalid : std_logic;
    VARIABLE wvalid : std_logic;
    VARIABLE arvalid : std_logic;
    VARIABLE arready : std_logic;
  BEGIN
    IF AXI4_Lite_AWVALID /= '0' THEN 
      awvalid := '1';
    ELSE 
      awvalid := '0';
    END IF;
    IF AXI4_Lite_WVALID /= '0' THEN 
      wvalid := '1';
    ELSE 
      wvalid := '0';
    END IF;
    IF AXI4_Lite_ARVALID /= '0' THEN 
      arvalid := '1';
    ELSE 
      arvalid := '0';
    END IF;
    CASE axi_lite_wstate IS
      WHEN "00000000" =>
        IF axi_lite_rstate = to_unsigned(16#00000000#, 8) THEN 
          out0 := '1';
        ELSE 
          out0 := '0';
        END IF;
        out1 := '0';
        AXI4_Lite_BVALID <= '0';
        IF (awvalid AND hdlcoder_to_stdlogic(axi_lite_rstate = to_unsigned(16#00000000#, 8))) = '1' THEN 
          axi_lite_wstate_next <= to_unsigned(16#01#, 8);
        ELSE 
          axi_lite_wstate_next <= to_unsigned(16#00#, 8);
        END IF;
      WHEN "00000001" =>
        out0 := '0';
        out1 := '1';
        AXI4_Lite_BVALID <= '0';
        IF wvalid = '1' THEN 
          axi_lite_wstate_next <= to_unsigned(16#02#, 8);
        ELSE 
          axi_lite_wstate_next <= to_unsigned(16#01#, 8);
        END IF;
      WHEN "00000010" =>
        out0 := '0';
        out1 := '0';
        AXI4_Lite_BVALID <= '1';
        IF AXI4_Lite_BREADY /= '0' THEN 
          axi_lite_wstate_next <= to_unsigned(16#00#, 8);
        ELSE 
          axi_lite_wstate_next <= to_unsigned(16#02#, 8);
        END IF;
      WHEN OTHERS => 
        out0 := '0';
        out1 := '0';
        AXI4_Lite_BVALID <= '0';
        axi_lite_wstate_next <= to_unsigned(16#00#, 8);
    END CASE;
    CASE axi_lite_rstate IS
      WHEN "00000000" =>
        arready := hdlcoder_to_stdlogic(axi_lite_wstate = to_unsigned(16#00000000#, 8)) AND ( NOT awvalid);
        rvalid_int <= '0';
        IF ((arvalid AND hdlcoder_to_stdlogic(axi_lite_wstate = to_unsigned(16#00000000#, 8))) AND ( NOT awvalid)) = '1' THEN 
          axi_lite_rstate_next <= to_unsigned(16#01#, 8);
        ELSE 
          axi_lite_rstate_next <= to_unsigned(16#00#, 8);
        END IF;
      WHEN "00000001" =>
        arready := '0';
        rvalid_int <= '1';
        IF AXI4_Lite_RREADY /= '0' THEN 
          axi_lite_rstate_next <= to_unsigned(16#00#, 8);
        ELSE 
          axi_lite_rstate_next <= to_unsigned(16#01#, 8);
        END IF;
      WHEN OTHERS => 
        arready := '0';
        rvalid_int <= '0';
        axi_lite_rstate_next <= to_unsigned(16#00#, 8);
    END CASE;
    AXI4_Lite_AWREADY <= out0;
    AXI4_Lite_WREADY <= out1;
    AXI4_Lite_ARREADY <= arready;
    aw_transfer <= awvalid AND out0;
    w_transfer <= wvalid AND out1;
    ar_transfer <= arvalid AND arready;
  END PROCESS axi_lite_output;


  const_0_2 <= to_unsigned(16#0#, 2);

  AXI4_Lite_BRESP <= std_logic_vector(const_0_2);

  data_read_unsigned <= unsigned(data_read);

  reg_rdata_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      AXI4_Lite_RDATA_tmp <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND ar_transfer = '1' THEN
        AXI4_Lite_RDATA_tmp <= data_read_unsigned;
      END IF;
    END IF;
  END PROCESS reg_rdata_process;


  AXI4_Lite_RDATA <= std_logic_vector(AXI4_Lite_RDATA_tmp);

  AXI4_Lite_RRESP <= std_logic_vector(const_0_2);

  AXI4_Lite_RVALID <= rvalid_int;

  AXI4_Lite_WDATA_unsigned <= unsigned(AXI4_Lite_WDATA);

  reg_wdata_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      wdata <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND w_transfer = '1' THEN
        wdata <= AXI4_Lite_WDATA_unsigned;
      END IF;
    END IF;
  END PROCESS reg_wdata_process;


  data_write <= std_logic_vector(wdata);

  AXI4_Lite_AWADDR_unsigned <= unsigned(AXI4_Lite_AWADDR);

  reg_waddr_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      waddr <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND aw_transfer = '1' THEN
        waddr <= AXI4_Lite_AWADDR_unsigned;
      END IF;
    END IF;
  END PROCESS reg_waddr_process;


  waddr_sel <= waddr(15 DOWNTO 2);

  AXI4_Lite_ARADDR_unsigned <= unsigned(AXI4_Lite_ARADDR);

  raddr_sel <= AXI4_Lite_ARADDR_unsigned(15 DOWNTO 2);

  
  addr_sel_tmp <= waddr_sel WHEN AXI4_Lite_ARVALID = '0' ELSE
      raddr_sel;

  addr_sel <= std_logic_vector(addr_sel_tmp);

  AXI4_Lite_WSTRB_unsigned <= unsigned(AXI4_Lite_WSTRB);

  wstrb_reduce <= (AXI4_Lite_WSTRB_unsigned(3) AND AXI4_Lite_WSTRB_unsigned(2) AND AXI4_Lite_WSTRB_unsigned(1) AND AXI4_Lite_WSTRB_unsigned(0));

  w_transfer_and_wstrb <= w_transfer AND wstrb_reduce;

  reg_wr_enb_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      wr_enb_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        wr_enb_1 <= w_transfer_and_wstrb;
      END IF;
    END IF;
  END PROCESS reg_wr_enb_process;


  rd_enb <= ar_transfer;

  
  strobe_addr <= '1' WHEN waddr_sel = to_unsigned(16#0000#, 14) ELSE
      '0';

  strobe_sel <= strobe_addr AND wr_enb_1;

  const_zero <= '0';

  strobe_in <= wdata(0);

  
  strobe_sw <= const_zero WHEN strobe_sel = '0' ELSE
      strobe_in;

  reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      soft_reset <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        soft_reset <= strobe_sw;
      END IF;
    END IF;
  END PROCESS reg_process;


  reset_internal <= reset OR soft_reset;

  wr_enb <= wr_enb_1;

END rtl;

