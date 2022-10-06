/*
 * File Name:         hdl_prj\ipcore\qam_mapping_v1_0\include\qam_mapping_addr.h
 * Description:       C Header File
 * Created:           2022-10-06 15:06:38
*/

#ifndef QAM_MAPPING_H_
#define QAM_MAPPING_H_

#define  IPCore_Reset_qam_mapping                           0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_qam_mapping                          0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_PacketSize_AXI4_Stream_Master_qam_mapping   0x8  //Packet size for AXI4-Stream Master interface, the default value is 1024. The TLAST output signal of the AXI4-Stream Master interface is generated based on the packet size.
#define  IPCore_Timestamp_qam_mapping                       0xC  //contains unique IP timestamp (yymmddHHMM): 2210061506

#endif /* QAM_MAPPING_H_ */
