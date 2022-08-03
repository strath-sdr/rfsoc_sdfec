def non_5G_ldpc_ctrl_enc(id, code):
    id = '{0:08b}'.format(id)
    reserved = '{0:017b}'.format(0)
    code = '{0:07b}'.format(code)
    
    print('Non-5G NR Control Interface Definitions for LDPC Encode')
    print('\tID: ', int(id,2))
    print('\tCODE: ', int(code,2))
    
    ctrl = id + reserved + code
    
    return(int(ctrl,2))

def non_5G_ldpc_ctrl_dec(id, 
                         max_iterations, 
                         term_on_no_change, 
                         term_on_pass, 
                         include_parity_op,
                         hard_op, 
                         code):
    id = '{0:08b}'.format(id)                               # (31:24) uint8
    max_iterations = '{0:06b}'.format(max_iterations)       # (23:18) uint6
    term_on_no_change = '{0:01b}'.format(term_on_no_change) # (17:17) bit1
    term_on_pass = '{0:01b}'.format(term_on_pass)           # (16:16) bit1
    include_parity_op = '{0:01b}'.format(include_parity_op) # (15:15) bit1
    hard_op = '{0:01b}'.format(hard_op)                     # (14:14) bit1
    reserved = '{0:07b}'.format(0)                          # (13:7) uint7
    code = '{0:07b}'.format(code)                           # (6:0) uint7
    
    print('Non-5G NR Control Interface Definitions for LDPC Decode')
    print('\tID: ', int(id,2))
    print('\tMax Iter: ', int(max_iterations,2))
    print('\tTerm No Change: ', int(term_on_no_change,2))
    print('\tTerm Pass: ', int(term_on_pass,2))
    print('\tParity Pass: ', int(include_parity_op,2))
    print('\tHard OP: ', int(hard_op,2))
    print('\tCode: ', int(code,2))
    
    ctrl = id + max_iterations + term_on_no_change + term_on_pass \
    + include_parity_op + hard_op + reserved + code
    print('\tBinary: ', ctrl)
    
    return(int(ctrl,2))

def non_5G_ldpc_status_enc(status):
    binary = '{0:032b}'.format(status)
    
    id = binary[0:8]
    hard_op = binary[17]
    op = binary[18]
    code = binary[24:32]

    print('ID: ', int(id,2))
    print('Hard OP: ', int(hard_op,2))
    print('OP: ', int(op,2))
    print('Code: ', int(code,2))
    
def non_5G_ldpc_status_dec(status):
    binary = '{0:032b}'.format(status)
    
    id = binary[0:8]              # (31:24) uint8
    dec_iter = binary[8:14]       # (23:18) uint6
    term_no_change = binary[14]   # (17:17) bit1 
    term_pass = binary[15]        # (16:16) bit1
    parity_pass = binary[16]      # (15:15) bit1
    hard_op = binary[17]          # (14:14) bit1 
    code = binary[24:32]          # (6:0) uint7

    print('ID: ', int(id,2), len(id))
    print('Dec Iter: ', int(dec_iter,2), len(dec_iter))
    print('Term No Change: ', int(term_no_change,2), len(term_no_change))
    print('Term Pass: ', int(term_pass,2), len(term_pass))
    print('Parity Pass: ', int(parity_pass,2), len(parity_pass))
    print('Hard OP: ', int(hard_op,2), len(hard_op))
#     print('OP: ', int(op,2), len(op))
    print('Code: ', int(code,2), len(code))
    
def format_llr(v):
    # Perform symmetric saturation
    if v > 7.75:
        v = 7.75
    elif v < -7.75:
        v = -7.75

    v = int(v * pow(2,2)) # Bit shift to expose 2 fractional

    # Convert to binary (2's complement)
    if v >= 0:
        b = '{0:06b}'.format(v)
    else:
        b = '{0:06b}'.format(pow(2,6)+v)

    # Sign extend to 8-bits
    if b[0] == '0': # Number is positive
        b_ex = '00' + b
    else: # Number is negative
        b_ex = '11' + b

    return int(b_ex,2)