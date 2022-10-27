/*
 * File Name:         hdl_32bit\ipcore\encoder_control_v1_0\include\encoder_control_addr.h
 * Description:       C Header File
 * Created:           2022-10-27 12:29:37
*/

#ifndef ENCODER_CONTROL_H_
#define ENCODER_CONTROL_H_

#define  IPCore_Reset_encoder_control           0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_encoder_control          0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_encoder_control       0x8  //contains unique IP timestamp (yymmddHHMM): 2210271229
#define  aximm_ctrl_word_Data_encoder_control   0x100  //data register for Inport aximm_ctrl_word
#define  aximm_length_Data_encoder_control      0x104  //data register for Inport aximm_length
#define  aximm_load_Data_encoder_control        0x108  //data register for Inport aximm_load

#endif /* ENCODER_CONTROL_H_ */
