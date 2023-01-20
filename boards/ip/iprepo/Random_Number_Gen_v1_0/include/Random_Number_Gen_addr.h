/*
 * File Name:         hdl_prj\ipcore\Random_Number_Gen_v1_0\include\Random_Number_Gen_addr.h
 * Description:       C Header File
 * Created:           2023-01-13 11:55:54
*/

#ifndef RANDOM_NUMBER_GEN_H_
#define RANDOM_NUMBER_GEN_H_

#define  IPCore_Reset_Random_Number_Gen        0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_Random_Number_Gen       0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_Random_Number_Gen    0x8  //contains unique IP timestamp (yymmddHHMM): 2301131155
#define  aximm_enable_Data_Random_Number_Gen   0x100  //data register for Inport aximm_enable
#define  aximm_bits_Data_Random_Number_Gen     0x104  //data register for Inport aximm_bits
#define  aximm_reset_Data_Random_Number_Gen    0x108  //data register for Inport aximm_reset

#endif /* RANDOM_NUMBER_GEN_H_ */
