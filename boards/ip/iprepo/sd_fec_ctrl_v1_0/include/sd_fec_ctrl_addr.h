/*
 * File Name:         hdl_prj\ipcore\sd_fec_ctrl_v1_0\include\sd_fec_ctrl_addr.h
 * Description:       C Header File
 * Created:           2022-10-06 15:04:28
*/

#ifndef SD_FEC_CTRL_H_
#define SD_FEC_CTRL_H_

#define  IPCore_Reset_sd_fec_ctrl           0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_sd_fec_ctrl          0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_sd_fec_ctrl       0x8  //contains unique IP timestamp (yymmddHHMM): 2210061504
#define  aximm_ctrl_word_Data_sd_fec_ctrl   0x100  //data register for Inport aximm_ctrl_word
#define  aximm_length_Data_sd_fec_ctrl      0x104  //data register for Inport aximm_length
#define  aximm_load_Data_sd_fec_ctrl        0x108  //data register for Inport aximm_load

#endif /* SD_FEC_CTRL_H_ */
