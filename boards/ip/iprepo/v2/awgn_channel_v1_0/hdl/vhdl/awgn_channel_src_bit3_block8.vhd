-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\awgn_channel_src_bit3_block8.vhd
-- Created: 2022-10-27 12:50:14
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: awgn_channel_src_bit3_block8
-- Source Path: fec_ber_hw_V2/AWGN Channel/AWGN/Subsystem/AWGN Generator4/Random Number Generator1/bit3
-- Hierarchy Level: 5
-- 
-- PN Sequence Generator
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY awgn_channel_src_bit3_block8 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        inportReset                       :   IN    std_logic;
        PN_Sequence                       :   OUT   std_logic
        );
END awgn_channel_src_bit3_block8;


ARCHITECTURE rtl OF awgn_channel_src_bit3_block8 IS

  -- Constants
  CONSTANT VectorTDL_data                 : std_logic_vector(0 TO 12) := 
    ('0', '0', '1', '1', '1', '1', '1', '0', '0', '0', '0', '0', '1');  -- ufix1 [13]

  -- Signals
  SIGNAL InitStates                       : std_logic_vector(0 TO 12);  -- boolean [13]
  SIGNAL TDL                              : std_logic_vector(0 TO 12);  -- boolean [13]
  SIGNAL TDL_12                           : std_logic;
  SIGNAL TDL_4                            : std_logic;
  SIGNAL TDL_1                            : std_logic;
  SIGNAL TDL_0                            : std_logic;
  SIGNAL PNSeqOut                         : std_logic;
  SIGNAL TDL_2                            : std_logic_vector(0 TO 12);  -- boolean [13]
  SIGNAL TDLPrevious                      : std_logic_vector(0 TO 12);  -- boolean [13]
  SIGNAL OutputMask                       : std_logic_vector(0 TO 12);  -- boolean [13]
  SIGNAL MaskANDtoXOR                     : std_logic_vector(0 TO 12);  -- boolean [13]
  SIGNAL MaskANDtoXOR_0                   : std_logic;
  SIGNAL MaskANDtoXOR_1                   : std_logic;
  SIGNAL MaskANDtoXOR_2                   : std_logic;
  SIGNAL MaskANDtoXOR_3                   : std_logic;
  SIGNAL MaskANDtoXOR_4                   : std_logic;
  SIGNAL MaskANDtoXOR_5                   : std_logic;
  SIGNAL MaskANDtoXOR_6                   : std_logic;
  SIGNAL MaskANDtoXOR_7                   : std_logic;
  SIGNAL MaskANDtoXOR_8                   : std_logic;
  SIGNAL MaskANDtoXOR_9                   : std_logic;
  SIGNAL MaskANDtoXOR_10                  : std_logic;
  SIGNAL MaskANDtoXOR_11                  : std_logic;
  SIGNAL MaskANDtoXOR_12                  : std_logic;
  SIGNAL PNSeqBits                        : std_logic;

BEGIN
  InitStates(0) <= '0';
  InitStates(1) <= '0';
  InitStates(2) <= '1';
  InitStates(3) <= '1';
  InitStates(4) <= '1';
  InitStates(5) <= '1';
  InitStates(6) <= '1';
  InitStates(7) <= '0';
  InitStates(8) <= '0';
  InitStates(9) <= '0';
  InitStates(10) <= '0';
  InitStates(11) <= '0';
  InitStates(12) <= '1';

  TDL_12 <= TDL(12);

  TDL_4 <= TDL(4);

  TDL_1 <= TDL(1);

  TDL_0 <= TDL(0);

  PNSeqOut <= TDL_12 XOR (TDL_4 XOR (TDL_0 XOR TDL_1));

  TDL_2(0) <= PNSeqOut;
  TDL_2(1) <= TDL(0);
  TDL_2(2) <= TDL(1);
  TDL_2(3) <= TDL(2);
  TDL_2(4) <= TDL(3);
  TDL_2(5) <= TDL(4);
  TDL_2(6) <= TDL(5);
  TDL_2(7) <= TDL(6);
  TDL_2(8) <= TDL(7);
  TDL_2(9) <= TDL(8);
  TDL_2(10) <= TDL(9);
  TDL_2(11) <= TDL(10);
  TDL_2(12) <= TDL(11);

  VectorTDL_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      TDLPrevious <= VectorTDL_data;
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_4_0 = '1' THEN
        TDLPrevious <= TDL_2;
      END IF;
    END IF;
  END PROCESS VectorTDL_process;


  
  TDL <= TDLPrevious WHEN inportReset = '0' ELSE
      InitStates;

  OutputMask(0) <= '0';
  OutputMask(1) <= '0';
  OutputMask(2) <= '0';
  OutputMask(3) <= '0';
  OutputMask(4) <= '0';
  OutputMask(5) <= '0';
  OutputMask(6) <= '0';
  OutputMask(7) <= '0';
  OutputMask(8) <= '0';
  OutputMask(9) <= '0';
  OutputMask(10) <= '0';
  OutputMask(11) <= '0';
  OutputMask(12) <= '1';


  MaskANDtoXOR_gen: FOR t_0 IN 0 TO 12 GENERATE
    MaskANDtoXOR(t_0) <= TDL(t_0) AND OutputMask(t_0);
  END GENERATE MaskANDtoXOR_gen;


  MaskANDtoXOR_0 <= MaskANDtoXOR(0);

  MaskANDtoXOR_1 <= MaskANDtoXOR(1);

  MaskANDtoXOR_2 <= MaskANDtoXOR(2);

  MaskANDtoXOR_3 <= MaskANDtoXOR(3);

  MaskANDtoXOR_4 <= MaskANDtoXOR(4);

  MaskANDtoXOR_5 <= MaskANDtoXOR(5);

  MaskANDtoXOR_6 <= MaskANDtoXOR(6);

  MaskANDtoXOR_7 <= MaskANDtoXOR(7);

  MaskANDtoXOR_8 <= MaskANDtoXOR(8);

  MaskANDtoXOR_9 <= MaskANDtoXOR(9);

  MaskANDtoXOR_10 <= MaskANDtoXOR(10);

  MaskANDtoXOR_11 <= MaskANDtoXOR(11);

  MaskANDtoXOR_12 <= MaskANDtoXOR(12);

  PNSeqBits <= MaskANDtoXOR_12 XOR (MaskANDtoXOR_11 XOR (MaskANDtoXOR_10 XOR (MaskANDtoXOR_9 XOR (MaskANDtoXOR_8 XOR (MaskANDtoXOR_7 XOR (MaskANDtoXOR_6 XOR (MaskANDtoXOR_5 XOR (MaskANDtoXOR_4 XOR (MaskANDtoXOR_3 XOR (MaskANDtoXOR_2 XOR (MaskANDtoXOR_0 XOR MaskANDtoXOR_1)))))))))));

  
  PN_Sequence <= '1' WHEN PNSeqBits /= '0' ELSE
      '0';

END rtl;

