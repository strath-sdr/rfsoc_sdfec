/*
 * File Name:         hdl_prj\ipcore\qam_mapping_v1_3\include\qam_mapping_addr.h
 * Description:       C Header File
 * Created:           2023-01-16 15:11:33
*/

#ifndef QAM_MAPPING_H_
#define QAM_MAPPING_H_

#define  IPCore_Reset_qam_mapping       0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_qam_mapping      0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_qam_mapping   0x8  //contains unique IP timestamp (yymmddHHMM): 2301161321: 2301161511
#define  aximm_valid_Data_qam_mapping   0x100  //data register for Inport aximm_valid

#endif /* QAM_MAPPING_H_ */
