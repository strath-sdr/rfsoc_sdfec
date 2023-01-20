/*
 * File Name:         hdl_prj\ipcore\FEC_Ctrl_v1_2\include\FEC_Ctrl_addr.h
 * Description:       C Header File
 * Created:           2022-11-23 17:53:28
*/

#ifndef FEC_CTRL_H_
#define FEC_CTRL_H_

#define  IPCore_Reset_FEC_Ctrl        0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_FEC_Ctrl       0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_FEC_Ctrl    0x8  //contains unique IP timestamp (yymmddHHMM): 2211231753
#define  aximm_ctrl_Data_FEC_Ctrl     0x100  //data register for Inport aximm_ctrl
#define  aximm_length_Data_FEC_Ctrl   0x104  //data register for Inport aximm_length

#endif /* FEC_CTRL_H_ */
