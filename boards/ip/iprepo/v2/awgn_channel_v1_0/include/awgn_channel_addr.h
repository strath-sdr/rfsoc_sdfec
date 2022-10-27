/*
 * File Name:         hdl_32bits\ipcore\awgn_channel_v1_0\include\awgn_channel_addr.h
 * Description:       C Header File
 * Created:           2022-10-27 12:50:22
*/

#ifndef AWGN_CHANNEL_H_
#define AWGN_CHANNEL_H_

#define  IPCore_Reset_awgn_channel            0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_awgn_channel           0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_awgn_channel        0x8  //contains unique IP timestamp (yymmddHHMM): 2210271250
#define  aximm_noise_std_Data_awgn_channel    0x100  //data register for Inport aximm_noise_std
#define  aximm_awgn_reset_Data_awgn_channel   0x104  //data register for Inport aximm_awgn_reset

#endif /* AWGN_CHANNEL_H_ */
