/*
 * File Name:         hdl_prj\ipcore\awgn_channel_v1_0\include\awgn_channel_addr.h
 * Description:       C Header File
 * Created:           2022-11-22 20:34:32
*/

#ifndef AWGN_CHANNEL_H_
#define AWGN_CHANNEL_H_

#define  IPCore_Reset_awgn_channel           0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_awgn_channel          0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_awgn_channel       0x8  //contains unique IP timestamp (yymmddHHMM): 2211222030: 2211222031: 2211222034
#define  aximm_noise_std_Data_awgn_channel   0x100  //data register for Inport aximm_noise_std

#endif /* AWGN_CHANNEL_H_ */
