-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example\soft_demodulation_addr_decoder.vhd
-- Created: 2022-11-22 20:57:49
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: soft_demodulation_addr_decoder
-- Source Path: soft_demodulation/soft_demodulation_axi_lite/soft_demodulation_addr_decoder
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY soft_demodulation_addr_decoder IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        data_write                        :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        addr_sel                          :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14
        wr_enb                            :   IN    std_logic;  -- ufix1
        rd_enb                            :   IN    std_logic;  -- ufix1
        read_ip_timestamp                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        data_read                         :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_axi_enable                  :   OUT   std_logic;  -- ufix1
        write_aximm_llr_scale             :   OUT   std_logic_vector(31 DOWNTO 0)  -- ufix32_En12
        );
END soft_demodulation_addr_decoder;


ARCHITECTURE rtl OF soft_demodulation_addr_decoder IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL addr_sel_unsigned                : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL decode_sel_ip_timestamp_1_1      : std_logic;  -- ufix1
  SIGNAL read_ip_timestamp_unsigned       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL const_1                          : std_logic;  -- ufix1
  SIGNAL const_0                          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_ip_timestamp            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_ip_timestamp_1_1       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_sel_axi_enable_1_1        : std_logic;  -- ufix1
  SIGNAL reg_enb_axi_enable_1_1           : std_logic;  -- ufix1
  SIGNAL data_write_unsigned              : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL data_in_axi_enable               : std_logic;  -- ufix1
  SIGNAL data_reg_axi_enable_1_1          : std_logic;  -- ufix1
  SIGNAL write_concats_axi_enable_1       : std_logic;  -- ufix1
  SIGNAL decode_sel_aximm_llr_scale_1_1   : std_logic;  -- ufix1
  SIGNAL reg_enb_aximm_llr_scale_1_1      : std_logic;  -- ufix1
  SIGNAL data_in_aximm_llr_scale          : unsigned(31 DOWNTO 0);  -- ufix32_En12
  SIGNAL data_reg_aximm_llr_scale_1_1     : unsigned(31 DOWNTO 0);  -- ufix32_En12

BEGIN
  addr_sel_unsigned <= unsigned(addr_sel);

  
  decode_sel_ip_timestamp_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0002#, 14) ELSE
      '0';

  read_ip_timestamp_unsigned <= unsigned(read_ip_timestamp);

  const_1 <= '1';

  enb <= const_1;

  const_0 <= to_unsigned(0, 32);

  reg_ip_timestamp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      read_reg_ip_timestamp <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        read_reg_ip_timestamp <= read_ip_timestamp_unsigned;
      END IF;
    END IF;
  END PROCESS reg_ip_timestamp_process;


  
  decode_rd_ip_timestamp_1_1 <= const_0 WHEN decode_sel_ip_timestamp_1_1 = '0' ELSE
      read_reg_ip_timestamp;

  data_read <= std_logic_vector(decode_rd_ip_timestamp_1_1);

  
  decode_sel_axi_enable_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0001#, 14) ELSE
      '0';

  reg_enb_axi_enable_1_1 <= decode_sel_axi_enable_1_1 AND wr_enb;

  data_write_unsigned <= unsigned(data_write);

  data_in_axi_enable <= data_write_unsigned(0);

  reg_axi_enable_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_axi_enable_1_1 <= '1';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_axi_enable_1_1 = '1' THEN
        data_reg_axi_enable_1_1 <= data_in_axi_enable;
      END IF;
    END IF;
  END PROCESS reg_axi_enable_1_1_process;


  write_concats_axi_enable_1 <= data_reg_axi_enable_1_1;

  write_axi_enable <= write_concats_axi_enable_1;

  
  decode_sel_aximm_llr_scale_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0040#, 14) ELSE
      '0';

  reg_enb_aximm_llr_scale_1_1 <= decode_sel_aximm_llr_scale_1_1 AND wr_enb;

  data_in_aximm_llr_scale <= data_write_unsigned;

  reg_aximm_llr_scale_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_aximm_llr_scale_1_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_aximm_llr_scale_1_1 = '1' THEN
        data_reg_aximm_llr_scale_1_1 <= data_in_aximm_llr_scale;
      END IF;
    END IF;
  END PROCESS reg_aximm_llr_scale_1_1_process;


  write_aximm_llr_scale <= std_logic_vector(data_reg_aximm_llr_scale_1_1);

END rtl;

