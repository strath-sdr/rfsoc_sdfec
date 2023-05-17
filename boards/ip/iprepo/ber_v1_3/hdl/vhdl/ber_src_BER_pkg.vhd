-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\book_example_v2\ber_src_BER_pkg.vhd
-- Created: 2023-01-16 12:06:04
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE ber_src_BER_pkg IS
  TYPE vector_of_unsigned32 IS ARRAY (NATURAL RANGE <>) OF unsigned(31 DOWNTO 0);
  TYPE vector_of_unsigned17 IS ARRAY (NATURAL RANGE <>) OF unsigned(16 DOWNTO 0);
END ber_src_BER_pkg;
