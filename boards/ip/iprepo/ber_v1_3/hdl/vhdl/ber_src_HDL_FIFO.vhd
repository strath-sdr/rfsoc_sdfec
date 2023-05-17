-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example_v2\ber_src_HDL_FIFO.vhd
-- Created: 2023-01-16 12:06:04
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ber_src_HDL_FIFO
-- Source Path: book_example_v2/BER/HDL_FIFO
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ber_src_HDL_FIFO IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In_rsvd                           :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        Push                              :   IN    std_logic;
        Pop                               :   IN    std_logic;
        Out_rsvd                          :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        Num                               :   OUT   std_logic_vector(16 DOWNTO 0)  -- ufix17
        );
END ber_src_HDL_FIFO;


ARCHITECTURE rtl OF ber_src_HDL_FIFO IS

  -- Component Declarations
  COMPONENT ber_src_SimpleDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb                             :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_en                           :   IN    std_logic;  -- ufix1
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ber_src_SimpleDualPortRAM_generic
    USE ENTITY work.ber_src_SimpleDualPortRAM_generic(rtl);

  -- Signals
  SIGNAL fifo_front_indx                  : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_front_dir                   : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_back_indx                   : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_back_dir                    : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_sample_count                : unsigned(16 DOWNTO 0);  -- ufix17
  SIGNAL fifo_front_indx_next             : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_front_dir_next              : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_back_indx_next              : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_back_dir_next               : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_sample_count_next           : unsigned(16 DOWNTO 0);  -- ufix17
  SIGNAL fifo_out3                        : std_logic;
  SIGNAL fifo_out4                        : std_logic;
  SIGNAL fifo_write_enable                : std_logic;
  SIGNAL fifo_read_enable                 : std_logic;
  SIGNAL fifo_front_indx_temp             : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_back_indx_temp              : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL w_waddr                          : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL w_we                             : std_logic;  -- ufix1
  SIGNAL w_raddr                          : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL Empty                            : std_logic;  -- ufix1
  SIGNAL Full                             : std_logic;  -- ufix1
  SIGNAL Num_tmp                          : unsigned(16 DOWNTO 0);  -- ufix17
  SIGNAL w_cz                             : std_logic;
  SIGNAL w_const                          : std_logic;  -- ufix1
  SIGNAL w_mux1                           : std_logic;  -- ufix1
  SIGNAL w_d1                             : std_logic;  -- ufix1
  SIGNAL w_waddr_1                        : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL w_waddr_unsigned                 : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL w_d2                             : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL w_out                            : unsigned(7 DOWNTO 0);  -- uint8

BEGIN
  -- us2: Upsample by 1, Sample offset 0 
  -- 
  -- us3: Upsample by 1, Sample offset 0 
  -- 
  -- us1: Upsample by 1, Sample offset 0 
  u_HDL_FIFO_ram_generic : ber_src_SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 16,
                 DataWidth => 8
                 )
    PORT MAP( clk => clk,
              enb => enb,
              wr_din => In_rsvd,
              wr_addr => std_logic_vector(w_waddr),
              wr_en => w_we,  -- ufix1
              rd_addr => std_logic_vector(w_raddr),
              rd_dout => w_waddr_1
              );

  -- FIFO logic controller
  fifo_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      fifo_front_indx <= to_unsigned(16#0000#, 16);
      fifo_front_dir <= to_unsigned(16#0001#, 16);
      fifo_back_indx <= to_unsigned(16#0000#, 16);
      fifo_back_dir <= to_unsigned(16#0001#, 16);
      fifo_sample_count <= to_unsigned(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        fifo_front_indx <= fifo_front_indx_next;
        fifo_front_dir <= fifo_front_dir_next;
        fifo_back_indx <= fifo_back_indx_next;
        fifo_back_dir <= fifo_back_dir_next;
        fifo_sample_count <= fifo_sample_count_next;
      END IF;
    END IF;
  END PROCESS fifo_process;

  
  fifo_out4 <= '1' WHEN fifo_sample_count = to_unsigned(16#10000#, 17) ELSE
      '0';
  
  fifo_out3 <= '1' WHEN fifo_sample_count = to_unsigned(16#00000#, 17) ELSE
      '0';
  fifo_write_enable <= Push AND (Pop OR ( NOT fifo_out4));
  fifo_read_enable <= Pop AND ( NOT fifo_out3);
  
  fifo_front_indx_temp <= fifo_front_indx + fifo_front_dir WHEN fifo_read_enable = '1' ELSE
      fifo_front_indx;
  
  fifo_front_dir_next <= to_unsigned(16#0001#, 16) WHEN fifo_front_indx_temp = to_unsigned(16#FFFF#, 16) ELSE
      to_unsigned(16#0001#, 16);
  
  fifo_back_indx_temp <= fifo_back_indx + fifo_back_dir WHEN fifo_write_enable = '1' ELSE
      fifo_back_indx;
  
  fifo_back_dir_next <= to_unsigned(16#0001#, 16) WHEN fifo_back_indx_temp = to_unsigned(16#FFFF#, 16) ELSE
      to_unsigned(16#0001#, 16);
  
  fifo_sample_count_next <= fifo_sample_count + to_unsigned(16#00001#, 17) WHEN (fifo_write_enable AND ( NOT fifo_read_enable)) = '1' ELSE
      fifo_sample_count + to_unsigned(16#1FFFF#, 17) WHEN (( NOT fifo_write_enable) AND fifo_read_enable) = '1' ELSE
      fifo_sample_count;
  w_waddr <= fifo_back_indx;
  w_we <= fifo_write_enable;
  w_raddr <= fifo_front_indx;
  Empty <= fifo_out3;
  Full <= fifo_out4;
  Num_tmp <= fifo_sample_count;
  fifo_front_indx_next <= fifo_front_indx_temp;
  fifo_back_indx_next <= fifo_back_indx_temp;

  
  w_cz <= '1' WHEN Num_tmp > to_unsigned(16#00000#, 17) ELSE
      '0';

  w_const <= '0';

  
  w_mux1 <= w_const WHEN w_cz = '0' ELSE
      Pop;

  f_d1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      w_d1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        w_d1 <= w_mux1;
      END IF;
    END IF;
  END PROCESS f_d1_process;


  w_waddr_unsigned <= unsigned(w_waddr_1);

  f_d2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      w_d2 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND w_d1 = '1' THEN
        w_d2 <= w_waddr_unsigned;
      END IF;
    END IF;
  END PROCESS f_d2_process;


  
  w_out <= w_d2 WHEN w_d1 = '0' ELSE
      w_waddr_unsigned;

  Out_rsvd <= std_logic_vector(w_out);

  Num <= std_logic_vector(Num_tmp);

END rtl;
