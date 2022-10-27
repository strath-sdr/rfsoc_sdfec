/*
 * File Name:         hdl_prj\ipcore\random_number_gen_v1_0\include\random_number_gen_addr.h
 * Description:       C Header File
 * Created:           2022-10-06 14:58:27
*/

#ifndef RANDOM_NUMBER_GEN_H_
#define RANDOM_NUMBER_GEN_H_

#define  IPCore_Reset_random_number_gen            0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_random_number_gen           0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_random_number_gen        0x8  //contains unique IP timestamp (yymmddHHMM): 2210061458
#define  aximm_enable_Data_random_number_gen       0x100  //data register for Inport aximm_enable
#define  aximm_comparator_Data_random_number_gen   0x104  //data register for Inport aximm_comparator

#endif /* RANDOM_NUMBER_GEN_H_ */
