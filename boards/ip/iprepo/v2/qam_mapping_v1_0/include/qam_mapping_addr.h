/*
 * File Name:         hdl_32bits\ipcore\qam_mapping_v1_0\include\qam_mapping_addr.h
 * Description:       C Header File
 * Created:           2022-10-27 12:38:12
*/

#ifndef QAM_MAPPING_H_
#define QAM_MAPPING_H_

#define  IPCore_Reset_qam_mapping       0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_qam_mapping      0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_qam_mapping   0x8  //contains unique IP timestamp (yymmddHHMM): 2210271238

#endif /* QAM_MAPPING_H_ */
