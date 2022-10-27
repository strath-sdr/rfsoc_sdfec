-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\random_number_generator_src_mask_generator.vhd
-- Created: 2022-10-27 12:01:58
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: random_number_generator_src_mask_generator
-- Source Path: fec_ber_hw_V2/Random Number Generator/concat/mask_generator
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.random_number_generator_src_Random_Number_Generator_pkg.ALL;

ENTITY random_number_generator_src_mask_generator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        diff                              :   IN    std_logic_vector(32 DOWNTO 0);  -- sfix33
        sel                               :   IN    std_logic;
        mask                              :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
        );
END random_number_generator_src_mask_generator;


ARCHITECTURE rtl OF random_number_generator_src_mask_generator IS

  -- Component Declarations
  COMPONENT random_number_generator_src_falling_edge
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          in_rsvd                         :   IN    std_logic;
          pulse                           :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : random_number_generator_src_falling_edge
    USE ENTITY work.random_number_generator_src_falling_edge(rtl);

  -- Constants
  CONSTANT alpha1_D_Lookup_Table_data     : vector_of_unsigned32(0 TO 32) := 
    (to_unsigned(0, 32), to_unsigned(1, 32), to_unsigned(3, 32), to_unsigned(7, 32), to_unsigned(15, 32),
     to_unsigned(31, 32), to_unsigned(63, 32), to_unsigned(127, 32), to_unsigned(255, 32), to_unsigned(511, 32),
     to_unsigned(1023, 32), to_unsigned(2047, 32), to_unsigned(4095, 32), to_unsigned(8191, 32),
     to_unsigned(16383, 32), to_unsigned(32767, 32), to_unsigned(65535, 32), to_unsigned(131071, 32),
     to_unsigned(262143, 32), to_unsigned(524287, 32), to_unsigned(1048575, 32), to_unsigned(2097151, 32),
     to_unsigned(4194303, 32), to_unsigned(8388607, 32), to_unsigned(16777215, 32), to_unsigned(33554431, 32),
     to_unsigned(67108863, 32), to_unsigned(134217727, 32), to_unsigned(268435455, 32),
     to_unsigned(536870911, 32), to_unsigned(1073741823, 32), to_unsigned(2147483647, 32),
     unsigned'(X"FFFFFFFF"));  -- ufix32 [33]

  -- Signals
  SIGNAL falling_edge_out1                : std_logic;
  SIGNAL Constant6_out1                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Constant1_out1                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL diff_signed                      : signed(32 DOWNTO 0);  -- sfix33
  SIGNAL Subtract3_sub_cast               : signed(33 DOWNTO 0);  -- sfix34
  SIGNAL Subtract3_sub_temp               : signed(33 DOWNTO 0);  -- sfix34
  SIGNAL Subtract3_out1                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL alpha1_D_Lookup_Table_out1       : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Multiport_Switch_out1            : unsigned(31 DOWNTO 0);  -- uint32

BEGIN
  u_falling_edge : random_number_generator_src_falling_edge
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              in_rsvd => sel,
              pulse => falling_edge_out1
              );

  Constant6_out1 <= to_unsigned(16#20#, 8);

  Constant1_out1 <= unsigned'(X"FFFFFFFF");

  diff_signed <= signed(diff);

  Subtract3_sub_cast <= signed(resize(Constant6_out1, 34));
  Subtract3_sub_temp <= Subtract3_sub_cast - resize(diff_signed, 34);
  Subtract3_out1 <= unsigned(Subtract3_sub_temp(7 DOWNTO 0));

  alpha1_D_Lookup_Table_output : PROCESS (Subtract3_out1)
    VARIABLE dout_low : unsigned(31 DOWNTO 0);
    VARIABLE k : unsigned(5 DOWNTO 0);
    VARIABLE f : unsigned(31 DOWNTO 0);
    VARIABLE add_cast : signed(66 DOWNTO 0);
    VARIABLE cast : signed(32 DOWNTO 0);
    VARIABLE sub_cast : signed(32 DOWNTO 0);
    VARIABLE sub_cast_0 : signed(32 DOWNTO 0);
    VARIABLE sub_temp : signed(32 DOWNTO 0);
    VARIABLE mul_temp : signed(65 DOWNTO 0);
    VARIABLE add_cast_0 : signed(64 DOWNTO 0);
    VARIABLE add_cast_1 : signed(66 DOWNTO 0);
    VARIABLE add_temp : signed(66 DOWNTO 0);
  BEGIN
    IF Subtract3_out1 = to_unsigned(16#00#, 8) THEN 
      k := to_unsigned(16#00#, 6);
    ELSIF Subtract3_out1 >= to_unsigned(16#20#, 8) THEN 
      k := to_unsigned(16#20#, 6);
    ELSE 
      k := Subtract3_out1(5 DOWNTO 0);
    END IF;
    IF (Subtract3_out1 = to_unsigned(16#00#, 8)) OR (Subtract3_out1 >= to_unsigned(16#20#, 8)) THEN 
      f := to_unsigned(0, 32);
    ELSE 
      f := to_unsigned(0, 32);
    END IF;
    dout_low := alpha1_D_Lookup_Table_data(to_integer(k));
    IF k = to_unsigned(16#20#, 6) THEN 
      NULL;
    ELSE 
      k := k + to_unsigned(16#01#, 6);
    END IF;
    add_cast := signed(resize(dout_low & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 67));
    cast := signed(resize(f, 33));
    sub_cast := signed(resize(alpha1_D_Lookup_Table_data(to_integer(k)), 33));
    sub_cast_0 := signed(resize(dout_low, 33));
    sub_temp := sub_cast - sub_cast_0;
    mul_temp := cast * sub_temp;
    add_cast_0 := mul_temp(64 DOWNTO 0);
    add_cast_1 := resize(add_cast_0, 67);
    add_temp := add_cast + add_cast_1;
    alpha1_D_Lookup_Table_out1 <= unsigned(add_temp(63 DOWNTO 32));
  END PROCESS alpha1_D_Lookup_Table_output;


  
  Multiport_Switch_out1 <= Constant1_out1 WHEN falling_edge_out1 = '0' ELSE
      alpha1_D_Lookup_Table_out1;

  mask <= std_logic_vector(Multiport_Switch_out1);

END rtl;

