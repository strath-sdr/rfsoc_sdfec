/*
 * File Name:         hdl_prj\ipcore\ber_v1_0\include\ber_addr.h
 * Description:       C Header File
 * Created:           2022-10-06 19:12:05
*/

#ifndef BER_H_
#define BER_H_

#define  IPCore_Reset_ber                 0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_ber                0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_ber             0x8  //contains unique IP timestamp (yymmddHHMM): 2210061544: 2210061850: 2210061912
#define  aximm_bit_error_Data_ber         0x100  //data register for Outport aximm_bit_error
#define  aximm_bit_count_Data_ber         0x104  //data register for Outport aximm_bit_count
#define  aximm_fifo_num_Data_ber          0x108  //data register for Outport aximm_fifo_num
#define  aximm_bit_count_reset_Data_ber   0x10C  //data register for Inport aximm_bit_count_reset

#endif /* BER_H_ */
