import matplotlib.pyplot as plt
from pynq import allocate
import numpy as np

def add_multiple_ldpc_params(fec, ldpc_params):
    # use this function for table sizes: share_table_size!!!
    fec.CORE_ORDER = 0                         # In order outputs
    fec.CORE_AXIS_ENABLE = 0                   # Ensure FEC is disabled (000000)

    sc_offset = 0
    la_offset = 0
    qc_offset = 0
    print('Adding LDPC code parameters to "%s" internal memory.\n' % fec._fullpath)
    print("{:<10} {:<10} {:<10} {:<10} {:<10} {:<10}".format('Status','Code ID','SC Offset','LA Offset','QC Offset','Code Name'))
    print("{:<10} {:<10} {:<10} {:<10} {:<10} {:<10}".format('------','------','------','------','------','------'))
    for code_id in range(len(ldpc_params)):

        code_name = ldpc_params[code_id]
        sc_table = fec._code_params.ldpc[code_name]['sc_table']
        la_table = fec._code_params.ldpc[code_name]['la_table']
        qc_table = fec._code_params.ldpc[code_name]['qc_table']
        if type(sc_table) != list : sc_table = [sc_table]

        if (sc_offset + len(sc_table)) > len(fec.LDPC_SC_TABLE):
            print("\nNot enough space for SC table: %s. Terminating." % (code_name))
            break
        if (la_offset*4 + len(la_table)) > len(fec.LDPC_LA_TABLE):
            print("\nNot enough space for LA table: %s. Terminating." % (code_name))
            break
        if (qc_offset*4 + len(qc_table)) > len(fec.LDPC_QC_TABLE):
            print("\nNot enough space for QC table: %s. Terminating." % (code_name))
            break

        print("{:<10} {:<10} {:<10} {:<10} {:<10} {:<10}".format('Loaded',code_id, sc_offset, la_offset, qc_offset, code_name))
        fec.add_ldpc_params(code_id, sc_offset, la_offset, qc_offset, code_name)

        sc_offset += len(sc_table)
        la_offset += int(np.ceil(len(la_table)/4))
        qc_offset += int(np.ceil(len(qc_table)/4))

    fec.CORE_AXIS_ENABLE = 63                  # Enable FEC (111111)
    
def create_tx_buffer(fec, code_name, ldpc_params): 
    axis_width = 32 // 8
    num_words = 1
    pad = axis_width // num_words
    
    code_id = ldpc_params.index(code_name)
    k = fec._code_params.ldpc[code_name]['k']
    n = fec._code_params.ldpc[code_name]['n']
    
    if fec._code_params.ldpc[code_name]['dec_OK']:
        L = n
    else:
        L = int(np.ceil(k/8))
    
    print('Created TX buffer, size ', L)
    tx_buffer = allocate(shape=(L*pad,), dtype=np.uint8)
    return tx_buffer
    
def create_rx_buffer(fec, code_name, ldpc_params):
    axis_width = 32 // 8
    num_words = 1
    pad = axis_width // num_words
    
    code_id = ldpc_params.index(code_name)
    k = fec._code_params.ldpc[code_name]['k']
    n = fec._code_params.ldpc[code_name]['n']

    if fec._code_params.ldpc[code_name]['dec_OK']:
        L = int(np.ceil(k/8))
    else:
        L = int(np.ceil(n/8))
        
    print('Created RX buffer, size ', L)
    rx_buffer = allocate(shape=(L*pad,), dtype=np.uint8)
    return rx_buffer

def create_ctrl_buffer():
    ctrl_buffer = allocate(shape=(1,), dtype=np.uint32)
    return ctrl_buffer

def set_ctrl_reg(dma_ctrl, ctrl_buffer, ctrl_params_dict):
    ctrl_params = {'id' : 0, 
                    'max_iterations' : 0,
                    'term_on_no_change' : 0,
                    'term_on_pass' : 0, 
                    'include_parity_op' : 0,
                    'hard_op' : 0,
                    'code' : 0}

    for key in ctrl_params_dict:
        ctrl_params[key] = ctrl_params_dict[key]
    
    id = '{0:08b}'.format(ctrl_params['id'])                               # (31:24) uint8
    max_iterations = '{0:06b}'.format(ctrl_params['max_iterations'])       # (23:18) uint6
    term_on_no_change = '{0:01b}'.format(ctrl_params['term_on_no_change']) # (17:17) bit1
    term_on_pass = '{0:01b}'.format(ctrl_params['term_on_pass'])           # (16:16) bit1
    include_parity_op = '{0:01b}'.format(ctrl_params['include_parity_op']) # (15:15) bit1
    hard_op = '{0:01b}'.format(ctrl_params['hard_op'])                     # (14:14) bit1
    reserved = '{0:07b}'.format(0)                                         # (13:7) uint7
    code = '{0:07b}'.format(ctrl_params['code'])                           # (6:0) uint7
    
    print('\nControl\n-------')
    print('ID: ', int(id,2))
    print('Max Iter: ', int(max_iterations,2))
    print('Term No Change: ', int(term_on_no_change,2))
    print('Term Pass: ', int(term_on_pass,2))
    print('Parity Pass: ', int(include_parity_op,2))
    print('Hard OP: ', int(hard_op,2))
    print('Code: ', int(code,2))
    
    ctrl = id + max_iterations + term_on_no_change + term_on_pass \
    + include_parity_op + hard_op + reserved + code
    print('Binary: ', ctrl)
    
    ctrl_buffer[0] = (int(ctrl,2))
    
    dma_ctrl.sendchannel.transfer(ctrl_buffer)
    dma_ctrl.sendchannel.wait()
    
def create_status_buffer():
    status_buffer = allocate(shape=(1,), dtype=np.uint32)
    return status_buffer
    
def get_status_reg(dma_status, status_buffer):
    dma_status.recvchannel.transfer(status_buffer)
    dma_status.recvchannel.wait()
    
    binary = '{0:032b}'.format(status_buffer[0])
    
    id = binary[0:8]
    hard_op = binary[17]
    op = binary[18]
    code = binary[24:32]
    
    print('\nStatus\n------')
    print('Code ID: ', int(id,2))
    print('Hard Output: ', int(hard_op,2))
    print('Operation: ', int(op,2))
    print('Code Name: ', int(code,2))
    
def transfer_data(dma_data, tx_buffer, rx_buffer):
    dma_data.sendchannel.transfer(tx_buffer)
    dma_data.recvchannel.transfer(rx_buffer)
    dma_data.sendchannel.wait()
    dma_data.recvchannel.wait()
    
    return rx_buffer

def check_encoding(fec, tx_buffer, rx_buffer, code_name, ldpc_params):
    k = fec._code_params.ldpc[code_name]['k']
    K = int(np.ceil(k/8))
    pad = 4
    if not (tx_buffer[0:(K-1)*pad] == rx_buffer[0:(K-1)*pad]).all():
        print('\nFalse: ', code_name, np.asarray(np.where(tx_buffer[0:(K-1)*pad] != rx_buffer[0:(K-1)*pad]))/pad)
    else:
        print('\nEncoding successful [%s]' % code_name)
        
def serialise_data(data):
    pad = 4
    hard_data = data[::pad]

    hard_binary = ''
    for hd in hard_data:
        h_bin = '{0:08b}'.format(hd)
        hard_binary += h_bin[::-1] # Decoder accepts LSB first

    return hard_binary

def modulate(data, plot=False):
    L = 4 # Symbol length - 16-QAM
    
    mod_I = np.empty(0)
    mod_Q = np.empty(0)
    for i in range(0, len(data), L):
        symbol = data[i : i+L]

        b0b1 = symbol[0:2]
        b2b3 = symbol[2:4]

        if b0b1 == '00':
            I = -3
        elif b0b1 == '01':
            I = -1
        elif b0b1 == '11':
            I = 1
        elif b0b1 == '10':
            I = 3

        if b2b3 == '00':
            Q = -3
        elif b2b3 == '01':
            Q = -1
        elif b2b3 == '11':
            Q = 1
        elif b2b3 == '10':
            Q = 3

        mod_I = np.append(mod_I, I)
        mod_Q = np.append(mod_Q, Q)
        
    signal = mod_I + 1j*mod_Q

    if plot:
        plt.scatter(mod_I, mod_Q, s=1)
        plt.ylabel('Quadrature Amplitude')
        plt.xlabel('In-phase Amplitude')
        plt.title('Constellation Plot')
        plt.rcParams['figure.figsize'] = [3, 3]
        plt.rcParams['figure.dpi'] = 200
        plt.show

    return signal
        
def add_noise(signal, snr_db, plot=False):
    # Calculate nosie power
    snr = 10**(snr_db/10) # SNR ratio
    var_signal = np.var(signal) # power
    var_noise = var_signal / snr
    print('\nDesired SNR: %d dB' % snr_db)
    print('Var Signal: ', var_signal)
    print('Var Noise: ' ,var_noise)
    print('SNR (ratio): ', var_signal/var_noise)

    # Generate noise
    noise_len = len(signal)
    noise_mean = 0
    noise = (np.random.normal(noise_mean,np.sqrt(2)/2,noise_len) 
             + 1j*np.random.normal(noise_mean,np.sqrt(2)/2,noise_len))
    noise_scaled = noise * np.sqrt(var_noise)

    # Add noise to signal
    signal_with_noise = signal + noise_scaled

    # Measure SNR to verify
    power_signal = 10*np.log10(np.var(signal))
    power_noise = 10*np.log10(np.mean(np.abs(signal - signal_with_noise)**2))
    print('Measured SNR: ', power_signal - power_noise)
    
    if plot:
        # Plot signal with noise
        x = [n.real for n in signal_with_noise]
        y = [n.imag for n in signal_with_noise]   

        plt.scatter(x, y,s=1)
        plt.ylabel('Quadrature Amplitude')
        plt.xlabel('In-phase Amplitude')
        plt.title('Constellation Plot')
        plt.rcParams['figure.figsize'] = [3, 3]
        plt.rcParams['figure.dpi'] = 200
        plt.show
        
    return signal_with_noise

def soft_demodulate(signal):
    llrs = []
    for y in signal:
        # Bit 0
        if y.real < -2:
            b0 = 2*(y.real+1)
        elif y.real >= -2 and y.real < 2:
            b0 = y.real
        elif y.real > 2:
            b0 = 2*(y.real-1)

        # Bit 1
        b1 = -abs(y.real)+2

        # Bit 2
        if y.imag < -2:
            b2 = 2*(y.imag+1)
        elif y.imag >= -2 and y.imag < 2:
            b2 = y.imag
        elif y.imag > 2:
            b2 = 2*(y.imag-1) 

        # Bit 3
        b3 = -abs(y.imag)+2

        llrs.append(b0)
        llrs.append(b1)
        llrs.append(b2)
        llrs.append(b3)
        
    return llrs

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

def format_llrs(llrs):
    llrs_formatted = []
    for llr in llrs:
        llrs_formatted.append(format_llr(llr))
    return llrs_formatted