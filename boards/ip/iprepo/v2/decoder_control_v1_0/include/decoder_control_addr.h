/*
 * File Name:         hdl_32bits\ipcore\decoder_control_v1_0\include\decoder_control_addr.h
 * Description:       C Header File
 * Created:           2022-10-27 15:30:21
*/

#ifndef DECODER_CONTROL_H_
#define DECODER_CONTROL_H_

#define  IPCore_Reset_decoder_control           0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_decoder_control          0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_decoder_control       0x8  //contains unique IP timestamp (yymmddHHMM): 2210271530
#define  aximm_ctrl_word_Data_decoder_control   0x100  //data register for Inport aximm_ctrl_word
#define  aximm_length_Data_decoder_control      0x104  //data register for Inport aximm_length
#define  aximm_load_Data_decoder_control        0x108  //data register for Inport aximm_load

#endif /* DECODER_CONTROL_H_ */
