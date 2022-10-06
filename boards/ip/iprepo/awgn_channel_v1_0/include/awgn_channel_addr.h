/*
 * File Name:         hdl_prj\ipcore\awgn_channel_v1_0\include\awgn_channel_addr.h
 * Description:       C Header File
 * Created:           2022-10-06 15:11:28
*/

#ifndef AWGN_CHANNEL_H_
#define AWGN_CHANNEL_H_

#define  IPCore_Reset_awgn_channel                           0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_awgn_channel                          0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_PacketSize_AXI4_Stream_Master_awgn_channel   0x8  //Packet size for AXI4-Stream Master interface, the default value is 1024. The TLAST output signal of the AXI4-Stream Master interface is generated based on the packet size.
#define  IPCore_Timestamp_awgn_channel                       0xC  //contains unique IP timestamp (yymmddHHMM): 2210061511
#define  aximm_noise_std_Data_awgn_channel                   0x100  //data register for Inport aximm_noise_std
#define  aximm_awgn_reset_Data_awgn_channel                  0x104  //data register for Inport aximm_awgn_reset

#endif /* AWGN_CHANNEL_H_ */
