/*
 * File Name:         hdl_32bits\ipcore\random_number_generator_v1_0\include\random_number_generator_addr.h
 * Description:       C Header File
 * Created:           2022-10-27 12:02:01
*/

#ifndef RANDOM_NUMBER_GENERATOR_H_
#define RANDOM_NUMBER_GENERATOR_H_

#define  IPCore_Reset_random_number_generator        0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_random_number_generator       0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_random_number_generator    0x8  //contains unique IP timestamp (yymmddHHMM): 2210271201
#define  aximm_enable_Data_random_number_generator   0x100  //data register for Inport aximm_enable
#define  aximm_bits_Data_random_number_generator     0x104  //data register for Inport aximm_bits
#define  aximm_reset_Data_random_number_generator    0x108  //data register for Inport aximm_reset

#endif /* RANDOM_NUMBER_GENERATOR_H_ */
