import math
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as matches
from matplotlib.colors import ListedColormap
from IPython.display import set_matplotlib_formats
set_matplotlib_formats('svg')

def plot_parity_check_matrix(title,H,p=False):
    n = len(H[0])
    k = len(H)    
    
    strathclyde = '#6C8EBF'
    off_green = '#82B366'
    not_white = '#F1F1F2'
    old_computer = '#FDFCE8'
    cmap = ListedColormap([not_white, strathclyde])

    zeros_patch = matches.Patch(color=not_white, label='Zeros')
    ones_patch = matches.Patch(color=strathclyde, label='Ones')
    
    plt.rcParams['figure.figsize'] = [10, 5]
    plt.matshow(H, cmap=cmap)
    plt.title(title,fontsize=14)

    plt.tick_params(axis='x',bottom=True,top=False, labelbottom=True, labeltop=False)
    
    if p:
        plt.grid(color=off_green, linewidth=1)
        sm_patch = matches.Patch(color=off_green, label='Sub-Matrix Boundaries')
        plt.legend(handles=[zeros_patch, ones_patch, sm_patch], 
                   bbox_to_anchor=(1.05, 1), 
                   loc='upper left', 
                   borderaxespad=0., 
                   prop={'size': 10})
        x_pos = np.arange(n)[::p]-0.5
        xlabels = []
        for i in range(int(n/p)):
            label = 'Col %d' % i
            xlabels.append(label)
        plt.xticks(x_pos,xlabels,fontsize=10)

        y_pos = np.arange(k)[::p]-0.5
        ylabels = []
        for i in range(int(k/p)):
            label = 'Row %d' % i
            ylabels.append(label)
        plt.yticks(y_pos,ylabels,fontsize=10)
    else:
        plt.legend(handles=[zeros_patch, ones_patch], 
                   bbox_to_anchor=(1.05, 1), 
                   loc='upper left', 
                   borderaxespad=0., 
                   prop={'size': 10})
        plt.xticks(fontsize=10)
        plt.yticks(fontsize=10)

    plt.show()

def add_all_ldpc_params(fec):
    print('\nAdding LDPC Parameters to "%s" internal memory:' % (fec._fullpath))
    ldpc_params = fec.available_ldpc_params()
    
    fec.CORE_ORDER = 0                        # In order outputs
    fec.CORE_AXIS_ENABLE = 0                  # Ensure FEC is disabled (000000)

    sc_offset = 0
    la_offset = 0
    qc_offset = 0
    print("{:^10} {:^10} {:^10} {:^10} {:^10} {:^10}".format('----------',
                                                             '----------',
                                                             '----------',
                                                             '----------',
                                                             '----------',
                                                             '----------'))
    print("{:^10} {:^10} {:^10} {:^10} {:^10} {:^10}".format('Status',
                                                             'Code ID',
                                                             'SC Offset',
                                                             'LA Offset',
                                                             'QC Offset',
                                                             'Code Name'))
    print("{:^10} {:^10} {:^10} {:^10} {:^10} {:^10}".format('----------',
                                                             '----------',
                                                             '----------',
                                                             '----------',
                                                             '----------',
                                                             '----------'))
    for code_id in range(len(ldpc_params)):
        code_name = ldpc_params[code_id]
        table_sizes = fec.share_table_size(code_name)

        fec.add_ldpc_params(code_id,sc_offset,la_offset,qc_offset,code_name)
        print("{:^10} {:^10} {:^10} {:^10} {:^10} {:^10}".format('Loaded',
                                                                 code_id, 
                                                                 sc_offset, 
                                                                 la_offset, 
                                                                 qc_offset, 
                                                                 code_name))

        sc_offset += table_sizes['sc_size']
        la_offset += table_sizes['la_size']
        qc_offset += table_sizes['qc_size']

    fec.CORE_AXIS_ENABLE = 63                  # Enable FEC (111111)

def create_ctrl_word(ctrl_params_input, readout=False):
    ctrl_params = {'block_id' : 0, 
                    'max_iterations' : 0,
                    'term_on_no_change' : 0,
                    'term_on_pass' : 0, 
                    'include_parity_op' : 0,
                    'hard_op' : 0,
                    'code_id' : 0}

    for key in ctrl_params_input:
        ctrl_params[key] = ctrl_params_input[key]
    
    block_id = '{0:08b}'.format(ctrl_params['block_id'])                               # (31:24) uint8
    max_iterations = '{0:06b}'.format(ctrl_params['max_iterations'])       # (23:18) uint6
    term_on_no_change = '{0:01b}'.format(ctrl_params['term_on_no_change']) # (17:17) bit1
    term_on_pass = '{0:01b}'.format(ctrl_params['term_on_pass'])           # (16:16) bit1
    include_parity_op = '{0:01b}'.format(ctrl_params['include_parity_op']) # (15:15) bit1
    hard_op = '{0:01b}'.format(ctrl_params['hard_op'])                     # (14:14) bit1
    reserved = '{0:07b}'.format(0)                                         # (13:7) uint7
    code = '{0:07b}'.format(ctrl_params['code_id'])                        # (6:0) uint7
    
    if readout=='encoder':
        print('\nControl (Encoder)\n-----------------')
        print("{:>13} {:>0}".format('Block ID [31:24]:', int(block_id,2)))
        print("{:>13} {:>0}".format('Code ID [6:0]:', int(code,2)))
    elif readout=='decoder':
        print('\nControl (Decoder)\n-----------------')
        print("{:>24} {:>0}".format('Block ID [31:24]:', int(block_id,2)))
        print("{:>24} {:>0}".format('Max Iter [23:18]:', int(max_iterations,2)))
        print("{:>24} {:>0}".format('Term No Change [17:17]:', int(term_on_no_change,2)))
        print("{:>24} {:>0}".format('Term Pass [16:16]:', int(term_on_pass,2)))
        print("{:>24} {:>0}".format('Parity Pass [15:15]:', int(include_parity_op,2)))
        print("{:>24} {:>0}".format('Hard Output [14:14]:', int(hard_op,2)))
        print("{:>24} {:>0}".format('Code ID [6:0]:', int(code,2)))
    elif readout:
        print('\nControl (All)\n-------------')
        print("{:>24} {:>0}".format('Block ID [31:24]:', int(block_id,2)))
        print("{:>24} {:>0}".format('Max Iter [23:18]:', int(max_iterations,2)))
        print("{:>24} {:>0}".format('Term No Change [17:17]:', int(term_on_no_change,2)))
        print("{:>24} {:>0}".format('Term Pass [16:16]:', int(term_on_pass,2)))
        print("{:>24} {:>0}".format('Parity Pass [15:15]:', int(include_parity_op,2)))
        print("{:>24} {:>0}".format('Hard Output [14:14]:', int(hard_op,2)))
        print("{:>24} {:>0}".format('Reserved [13:7]:', '-'))
        print("{:>24} {:>0}".format('Code ID [6:0]:', int(code,2)))
    
    ctrl = block_id + max_iterations + term_on_no_change + term_on_pass \
    + include_parity_op + hard_op + reserved + code
    if readout:
        print('\nControl Word (bits):',ctrl)
    
    ctrl_buffer = (int(ctrl,2))
    return ctrl_buffer

def print_status_reg(status_buffer, readout=True):   
    binary = '{0:032b}'.format(status_buffer[0])
    
    id = binary[0:8]
    dec_iter = binary[8:14]
    term_no_change = binary[14]
    term_pass = binary[15]
    parity_pass = binary[16]
    hard_op = binary[17]
    op = binary[18]
    reserved = binary[19:25]
    code = binary[25:32]
    
    if readout=='encoder':
        print('\nStatus (Encoder)\n----------------')
        print("{:>20} {:>0}".format('Block ID [31:24]:', int(id,2)))
        print("{:>20} {:>0}".format('Hard Output [14:14]:', int(hard_op,2)))
        print("{:>20} {:>0}".format('Operation [13:13]:', int(op,2)))
        print("{:>20} {:>0}".format('Code Number [6:0]:', int(code,2)))
    elif readout=='decoder':
        print('\nStatus (Decoder)\n----------------')
        print("{:>24} {:>0}".format('Block ID [31:24]:', int(id,2)))
        print("{:>24} {:>0}".format('Decode Iter. [23:18]:', int(dec_iter,2)))
        print("{:>24} {:>0}".format('Term. No Change [17:17]:',int(term_no_change,2)))
        print("{:>24} {:>0}".format('Term. Pass [16:16]:',int(term_pass,2)))
        print("{:>24} {:>0}".format('Parity Pass [15:15]:',int(parity_pass,2)))
        print("{:>24} {:>0}".format('Hard Output [14:14]:', int(hard_op,2)))
        print("{:>24} {:>0}".format('Operation [13:13]:', int(op,2)))
        print("{:>24} {:>0}".format('Code Number [6:0]:', int(code,2)))
    else:
        print('\nStatus (All)\n------------')
        print("{:>24} {:>0}".format('Block ID [31:24]:', int(id,2)))
        print("{:>24} {:>0}".format('Decode Iter. [23:18]:', int(dec_iter,2)))
        print("{:>24} {:>0}".format('Term. No Change [17:17]:',int(term_no_change,2)))
        print("{:>24} {:>0}".format('Term. Pass [16:16]:',int(term_pass,2)))
        print("{:>24} {:>0}".format('Parity Pass [15:15]:',int(parity_pass,2)))
        print("{:>24} {:>0}".format('Hard Output [14:14]:', int(hard_op,2)))
        print("{:>24} {:>0}".format('Operation [13:13]:', int(op,2)))
        print("{:>24} {:>0}".format('Reserved [12:7]:', '-'))
        print("{:>24} {:>0}".format('Code Number [6:0]:', int(code,2)))
        
def serialise(data_buffer, order='lsb'):
    binary = np.array([])
    for hd in data_buffer:
        h_bin = '{0:08b}'.format(hd)
        if order == 'lsb':
            h_bin = h_bin[::-1] # Decoder accepts LSB first
        for i in h_bin:
            binary = np.append(binary,int(i))
    return binary
        
def plot_samples(title, x, y):
    """Function to plot up multiple timeseries on the same axis.
    
    Parameters
    ----------
    title : string
        The title of the plot.
    x : numerical array
        An array containing the x axes of the plots.
    y : numerical array
        An array containing the y axes of the plots.
    line : string array
        An array stating the plot type for each plot.
        (Continuous, discrete, dash)
    """
    plt.figure(figsize=(10,4))
    ax = plt.gca()
    ax.set_xlabel('Samples [n]')
    ax.set_ylabel('Amplitude')
    ax.grid(True)
    ax.set_title(title)
    
    colours = ['#0086CB', '#EA6B66', '#82B366']

    min_x = min(x[0])
    max_x = max(x[0])
    
    for i in range(len(x)):
        ax.step(list(x[i])+[max(x[i])+1,max(x[i])+2],
                [y[i][0]] + list(y[i]) + [y[i][-1]],
                colours[i])
        if min(x[i]) < min_x:
            min_x = min(x[i])
        if max(x[i]) > max_x:
            max_x = max(x[i])
    
    ax.set_xlim([min_x,max_x])
    plt.show()
    
def plot_constellation(complex_array):
    # Plot signal with noise
    x = [n.real for n in complex_array]
    y = [n.imag for n in complex_array]   

    plt.figure(figsize=(6,6))
    ax = plt.gca()
    ax.scatter(x, y,s=20,c='#0086CB')
    ax.set_ylabel('Quadrature Amplitude')
    ax.set_xlabel('In-phase Amplitude')
    ax.set_title('Constellation Plot')
    ax.grid(True)
    plt.show
    
def symbol_map(serial_data):
    L = 4 # Symbol length - 16-QAM
    
    mod_I = np.empty(0)
    mod_Q = np.empty(0)
    for i in range(0, len(serial_data), L):
        symbol = serial_data[i : i+L]

        b3b2 = symbol[0:2]
        b1b0 = symbol[2:4]

        if np.array_equal(b3b2,[0,0]):
            I = -3
        elif np.array_equal(b3b2,[0,1]):
            I = -1
        elif np.array_equal(b3b2,[1,1]):
            I = 1
        elif np.array_equal(b3b2,[1,0]):
            I = 3

        if np.array_equal(b1b0,[0,0]):
            Q = 3
        elif np.array_equal(b1b0,[0,1]):
            Q = 1
        elif np.array_equal(b1b0,[1,1]):
            Q = -1
        elif np.array_equal(b1b0,[1,0]):
            Q = -3

        mod_I = np.append(mod_I, I)
        mod_Q = np.append(mod_Q, Q)
        
    signal = mod_I + 1j*mod_Q   
    return signal

def awgn(signal, SNR):
    snr_ratio = 10**(SNR/10)
    var_signal = np.var(signal)
    var_noise = var_signal / snr_ratio
    var_scale = math.sqrt(var_noise/2)

    noise_mean = 0
    noise_len = len(signal)
    noise_I = np.random.normal(noise_mean,var_scale,noise_len)
    noise_Q = np.random.normal(noise_mean,var_scale,noise_len)
    noise = noise_I + 1j*noise_Q
    
    return signal + noise

def calc_llrs(signal):
    llrs = []
    for y in signal:
        # Bit 3
        if y.real < -2:
            b3 = 2*(y.real+1)
        elif y.real >= -2 and y.real < 2:
            b3 = y.real
        elif y.real > 2:
            b3 = 2*(y.real-1)

        # Bit 2
        b2 = -abs(y.real)+2

        # Bit 1
        if y.imag < -2:
            b1 = -2*(y.imag+1)
        elif y.imag >= -2 and y.imag < 2:
            b1 = -y.imag
        elif y.imag > 2:
            b1 = -2*(y.imag-1) 

        # Bit 0
        b0 = -abs(y.imag)+2

        llrs.append(b3)
        llrs.append(b2)
        llrs.append(b1)
        llrs.append(b0)
        
    return llrs

def hard_demod(signal):
    hard_bits = []
    for y in signal:
        if y.real >= 0:
            b3 = 1
        else:
            b3 = 0

        if y.real < 2 and y.real > -2:
            b2 = 1
        else:
            b2 = 0

        if y.imag >= 0:
            b1 = 0
        else:
            b1 = 1

        if y.imag < 2 and y.imag > -2:
            b0 = 1
        else:
            b0 = 0

        hard_bits.append(b3)
        hard_bits.append(b2)
        hard_bits.append(b1)
        hard_bits.append(b0)
        
    return hard_bits

def format_llr(llr):
    # Perform symmetric saturation
    if llr > 7.75:
        llr = 7.75
    elif llr < -7.75:
        llr = -7.75

    llr = int(llr * pow(2,2)) # Bit shift to expose 2 fractional

    # Convert to binary (2's complement)
    if llr >= 0:
        b = '{0:06b}'.format(llr)
    else:
        b = '{0:06b}'.format(pow(2,6)+llr)

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

def calculate_ber(tx_bits, rx_bits):
    compare = abs(np.asarray(rx_bits) - np.asarray(tx_bits))
    error_bits = np.sum(compare == 1)

    ber = error_bits / len(tx_bits)

    return ber

def fec_data_transfer(dma_data, tx_buffer, rx_buffer, 
                      dma_ctrl, ctrl_buffer, status_buffer, status=False):
    dma_ctrl.recvchannel.transfer(status_buffer)
    dma_data.recvchannel.transfer(rx_buffer)
    dma_ctrl.sendchannel.transfer(ctrl_buffer)
    dma_data.sendchannel.transfer(tx_buffer)
    
    dma_ctrl.sendchannel.wait()
    dma_data.sendchannel.wait()
    dma_ctrl.recvchannel.wait()
    dma_data.recvchannel.wait()
    
    if status:
        print_status_reg(status_buffer)
    
    return rx_buffer

def measure_snr(signal, signal_with_noise):
    power_signal = 10*np.log10(np.var(signal))
    power_noise = 10*np.log10(np.mean(np.abs(signal - signal_with_noise)**2))
    return power_signal - power_noise

def plot_ber(title, snrs, bers, codes):
    plt.figure(figsize=(8,6))
    ax = plt.gca()
    ax.set_yscale('log')
    ax.set_xlabel('SNR')
    ax.set_ylabel('BER')
    ax.grid(True)
    ax.set_title(title)
    ax.set_ylim([0.00001, 1])

    colours = ['#0086CB', '#EA6B66', '#82B366', '#7F3F91', '#D6B656']

    for i in range(len(bers)):
        ax.plot(snrs,bers[i],colours[i],label=codes[i])
    ax.legend()

    plt.show()
    
def plot_hist(title, signal,sigma,b=20):
    mu = 0
    
    count, bins, ignored = plt.hist(signal, b, density=True)
    plt.plot(bins, 1/(sigma * np.sqrt(2 * np.pi)) *
                   np.exp( - (bins - mu)**2 / (2 * sigma**2) ),
             linewidth=2, color='r')
    plt.show()
    
def interpret_llr(v):
    binary = '{0:08b}'.format(v)
    binary = binary[2:8]
    if binary[0] == '1':
        dec = -32 + int(binary[1:6],2)
    else:
        dec = int(binary[1:6],2)
    dec = dec / 4
    return dec

def interpret_llrs(llrs):
    llrs_interpret = []
    for llr in llrs:
        llrs_interpret.append(interpret_llr(llr))
    return llrs_interpret

def sign_extend(binary):
    if binary[0] == '0': 
        binary_extended = '00' + binary
    else:
        binary_extended = '11' + binary

    return binary_extended

def interpret_twos(value, n, f):
    if value[0] == '1':
        dec = -pow(2,n-1) + int(value[1:],2)
    else:
        dec = int(value[1:],2)
    dec = dec / pow(2,f)
    return dec

def twos_complement(value, n, f):
    value = value * pow(2,f)       # Bit shift to expose 2 fractional values
    value = int(np.round(value))   # Truncate remaining fractional values

    if value >= 0:
        if value > pow(2,n-1) - 1:
            value = pow(2,n-1) - 1
        binary = ('{0:0%sb}'%(n-1)).format(value)
        binary = '0'+binary[-n+1:]
    else:
        if value < -pow(2,n-1):
            value = -pow(2,n-1)
        binary = ('{0:0%sb}'%n).format(pow(2,n)+value)
    return binary

def print_llr_format_table(llrs,s,n):
    print("{:^14} {:^14} {:^14} {:^14}".format('--------------',
                                               '--------------',
                                               '--------------',
                                               '--------------'))
    print("{:^44}".format('Original Value'))
    print("{:^14} {:^14} {:^14} {:^14}".format('Original Value',
                                                 ' as 6-bit 2\'s ',
                                                 'DIN Value',
                                                 'DIN Input'))
    print("{:^44}".format('Complement Int'))
    print("{:^14} {:^14} {:^14} {:^14}".format('--------------',
                                                 '--------------',
                                                 '--------------',
                                                 '--------------'))
    for i in range(n):
        orig_v_twos = twos_complement(llrs[s+i],6,2)
        din_v = interpret_twos(orig_v_twos,6,2)
        print("{:^14} {:^14} {:^14} {:^14}".format("%.2f"%llrs[s+i],
                                                 orig_v_twos,
                                                 "%.2f"%din_v,
                                                 sign_extend(orig_v_twos)))