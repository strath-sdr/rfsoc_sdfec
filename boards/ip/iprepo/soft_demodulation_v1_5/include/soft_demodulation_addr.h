/*
 * File Name:         hdl_prj\ipcore\soft_demodulation_v1_5\include\soft_demodulation_addr.h
 * Description:       C Header File
 * Created:           2022-11-22 20:57:49
*/

#ifndef SOFT_DEMODULATION_H_
#define SOFT_DEMODULATION_H_

#define  IPCore_Reset_soft_demodulation           0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_soft_demodulation          0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_soft_demodulation       0x8  //contains unique IP timestamp (yymmddHHMM): 2211222039: 2211222040: 2211222057
#define  aximm_llr_scale_Data_soft_demodulation   0x100  //data register for Inport aximm_llr_scale

#endif /* SOFT_DEMODULATION_H_ */
