-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\fec_ber_hw\sd_fec_ctrl_src_Encoder_Ctrl_pkg.vhd
-- Created: 2022-10-06 15:04:26
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE sd_fec_ctrl_src_Encoder_Ctrl_pkg IS
  TYPE T_stateType IS (None, INIT, IDLE, LOAD_NVALID, CTRL, LOAD_VALID, COUNT_DIN, WAITING);
END sd_fec_ctrl_src_Encoder_Ctrl_pkg;
