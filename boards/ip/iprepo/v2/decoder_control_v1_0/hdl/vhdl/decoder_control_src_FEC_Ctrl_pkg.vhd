-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\decoder_control_src_FEC_Ctrl_pkg.vhd
-- Created: 2022-10-27 15:30:16
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE decoder_control_src_FEC_Ctrl_pkg IS
  TYPE T_stateType IS (None, INIT, IDLE, LOAD_NVALID, CTRL, LOAD_VALID, COUNT_DIN, WAITING);
END decoder_control_src_FEC_Ctrl_pkg;

