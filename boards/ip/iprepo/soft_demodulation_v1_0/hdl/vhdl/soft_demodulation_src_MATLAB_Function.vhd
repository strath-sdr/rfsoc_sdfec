-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\fec_ber_hw\soft_demodulation_src_MATLAB_Function.vhd
-- Created: 2022-10-06 15:14:46
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: soft_demodulation_src_MATLAB_Function
-- Source Path: fec_ber_hw/Soft Demodulation/MATLAB Function
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY soft_demodulation_src_MATLAB_Function IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        u                                 :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En12
        reset_1                           :   IN    std_logic;
        y                                 :   OUT   std_logic_vector(31 DOWNTO 0)  -- ufix32_En24
        );
END soft_demodulation_src_MATLAB_Function;


ARCHITECTURE rtl OF soft_demodulation_src_MATLAB_Function IS

  -- Signals
  SIGNAL u_signed                         : signed(23 DOWNTO 0);  -- sfix24_En12
  SIGNAL delayMatch_reg                   : std_logic_vector(0 TO 16);  -- ufix1 [17]
  SIGNAL reset_2                          : std_logic;
  SIGNAL y_tmp                            : unsigned(31 DOWNTO 0);  -- ufix32_En24
  SIGNAL max                              : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL max_next                         : unsigned(31 DOWNTO 0);  -- ufix32_En24

BEGIN
  u_signed <= signed(u);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= reset_1;
        delayMatch_reg(1 TO 16) <= delayMatch_reg(0 TO 15);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  reset_2 <= delayMatch_reg(16);

  lib_rfsoc_fec_c2_MATLAB_Function_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      max <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        max <= max_next;
      END IF;
    END IF;
  END PROCESS lib_rfsoc_fec_c2_MATLAB_Function_process;

  lib_rfsoc_fec_c2_MATLAB_Function_output : PROCESS (max, reset_2, u_signed)
    VARIABLE y1 : signed(23 DOWNTO 0);
    VARIABLE y_0 : signed(23 DOWNTO 0);
    VARIABLE max_temp : unsigned(31 DOWNTO 0);
    VARIABLE cast : signed(24 DOWNTO 0);
    VARIABLE cast_0 : signed(24 DOWNTO 0);
    VARIABLE cast_1 : signed(35 DOWNTO 0);
    VARIABLE cast_2 : signed(35 DOWNTO 0);
    VARIABLE cast_3 : signed(24 DOWNTO 0);
    VARIABLE cast_4 : signed(24 DOWNTO 0);
  BEGIN
    y_0 := to_signed(16#000000#, 24);
    cast_0 := to_signed(16#0000000#, 25);
    cast_4 := to_signed(16#0000000#, 25);
    cast := to_signed(16#0000000#, 25);
    cast_3 := to_signed(16#0000000#, 25);
    max_temp := max;
    IF u_signed < to_signed(16#000000#, 24) THEN 
      cast := resize(u_signed, 25);
      cast_0 :=  - (cast);
      IF (cast_0(24) = '0') AND (cast_0(23) /= '0') THEN 
        y1 := X"7FFFFF";
      ELSIF (cast_0(24) = '1') AND (cast_0(23) /= '1') THEN 
        y1 := X"800000";
      ELSE 
        y1 := cast_0(23 DOWNTO 0);
      END IF;
    ELSE 
      y1 := u_signed;
    END IF;
    cast_1 := y1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';
    cast_2 := signed(resize(max, 36));
    IF cast_1 > cast_2 THEN 
      IF u_signed < to_signed(16#000000#, 24) THEN 
        cast_3 := resize(u_signed, 25);
        cast_4 :=  - (cast_3);
        IF (cast_4(24) = '0') AND (cast_4(23) /= '0') THEN 
          y_0 := X"7FFFFF";
        ELSIF (cast_4(24) = '1') AND (cast_4(23) /= '1') THEN 
          y_0 := X"800000";
        ELSE 
          y_0 := cast_4(23 DOWNTO 0);
        END IF;
      ELSE 
        y_0 := u_signed;
      END IF;
      IF (y_0(23) = '0') AND (y_0(22 DOWNTO 20) /= "000") THEN 
        max_temp := X"FFFFFFFF";
      ELSIF y_0(23) = '1' THEN 
        max_temp := X"00000000";
      ELSE 
        max_temp := unsigned(y_0(19 DOWNTO 0) & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0');
      END IF;
    END IF;
    IF reset_2 = '1' THEN 
      max_temp := to_unsigned(0, 32);
    END IF;
    y_tmp <= max_temp;
    max_next <= max_temp;
  END PROCESS lib_rfsoc_fec_c2_MATLAB_Function_output;


  y <= std_logic_vector(y_tmp);

END rtl;

