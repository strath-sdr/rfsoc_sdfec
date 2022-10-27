/*
 * File Name:         hdl_32bits_hmm\ipcore\soft_demodulation_v1_0\include\soft_demodulation_addr.h
 * Description:       C Header File
 * Created:           2022-10-27 17:56:37
*/

#ifndef SOFT_DEMODULATION_H_
#define SOFT_DEMODULATION_H_

#define  IPCore_Reset_soft_demodulation               0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_soft_demodulation              0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_soft_demodulation           0x8  //contains unique IP timestamp (yymmddHHMM): 2210271756
#define  aximm_llr_scale_Data_soft_demodulation       0x100  //data register for Inport aximm_llr_scale
#define  aximm_llr_mag_reset_Data_soft_demodulation   0x104  //data register for Inport aximm_llr_mag_reset
#define  aximm_llr_max_Data_soft_demodulation         0x108  //data register for Outport aximm_llr_max

#endif /* SOFT_DEMODULATION_H_ */
