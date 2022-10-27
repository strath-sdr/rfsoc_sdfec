/*
 * File Name:         hdl_32bits\ipcore\BER_v1_0\include\BER_addr.h
 * Description:       C Header File
 * Created:           2022-10-27 15:45:33
*/

#ifndef BER_H_
#define BER_H_

#define  IPCore_Reset_BER                 0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_BER                0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_BER             0x8  //contains unique IP timestamp (yymmddHHMM): 2210271545
#define  aximm_bit_error_Data_BER         0x100  //data register for Outport aximm_bit_error
#define  aximm_bit_count_Data_BER         0x104  //data register for Outport aximm_bit_count
#define  aximm_fifo_num_Data_BER          0x108  //data register for Outport aximm_fifo_num
#define  aximm_bit_count_reset_Data_BER   0x110  //data register for Inport aximm_bit_count_reset
#define  aximm_length_Data_BER            0x114  //data register for Inport aximm_length

#endif /* BER_H_ */
