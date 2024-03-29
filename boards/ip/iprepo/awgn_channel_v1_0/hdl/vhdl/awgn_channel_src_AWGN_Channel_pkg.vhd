-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example\awgn_channel_src_AWGN_Channel_pkg.vhd
-- Created: 2022-11-22 20:34:30
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE awgn_channel_src_AWGN_Channel_pkg IS
  TYPE vector_of_signed16 IS ARRAY (NATURAL RANGE <>) OF signed(15 DOWNTO 0);
  TYPE vector_of_unsigned8 IS ARRAY (NATURAL RANGE <>) OF unsigned(7 DOWNTO 0);
  TYPE vector_of_signed17 IS ARRAY (NATURAL RANGE <>) OF signed(16 DOWNTO 0);
  TYPE vector_of_unsigned12 IS ARRAY (NATURAL RANGE <>) OF unsigned(11 DOWNTO 0);
  TYPE vector_of_signed4 IS ARRAY (NATURAL RANGE <>) OF signed(3 DOWNTO 0);
END awgn_channel_src_AWGN_Channel_pkg;

