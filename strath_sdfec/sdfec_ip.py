from pynq import DefaultIP
import asyncio
import threading
import warnings
import math
import numpy as np

# Func to return a MMIO getter and setter based on a relative addr
def _create_mmio_property(name, addr, s, w, f):
    def _get(self):
        v = self.read(addr)/(1<<f)
        if s and int(v/(1<<(32-f-1))):
             return v - pow(2,32-f)
        else:
             return v

    def _set(self, v):
        upper_lim = (pow(2,w-s)-1)
        lower_lim = -(pow(2,w-s))
        msg = ("Parameter overflow occurred for ''Value'' of register ''%s''"
        "The parameter''s value is outside the range that can be represented"
        " by fi(%d,%d,%d). The specified value was saturated to the closest"
        " representable value ") % (name,s,w,f)

        if v > upper_lim/(1<<f):
            v = upper_lim;
            warnings.warn(msg + "[%f]."%(upper_lim/(1<<f)))
        elif v < lower_lim/(1<<f):
            v = lower_lim;
            warnings.warn(msg + "[%f]."%(lower_lim/(1<<f)))
        else:
            if v < 0:
                v = round(pow(2,w) + v*(1<<f));
            else:
                v = round(v*(1<<f));

        self.write(addr, int(v))

    return property(_get, _set)


class AWGNChannel(DefaultIP):
    def __init__(self, description):
        super().__init__(description=description)
        
        self.p_avg = 10
        self.snr = 20
        self.noise_var = self.calculate_variance()
        
    def reset_ip(self):
        self.reset = 1
        self.reset = 0
        
    def calculate_variance(self):
        noise_var = self.p_avg / 10**(self.snr/10)
        return noise_var
        
    def set_snr(self, snr):
        self.snr = snr
        self.noise_var = self.calculate_variance()
        self.var_scale = math.sqrt(self.noise_var/2)

    bindto = ['strathsdr.org:rfsoc_sdfec:awgn_channel:1.0']

# LUT of property addresses for our data-driven properties
_awgn_channel_props = [
    ("reset",int('0',16),0,32,0),
    ("var_scale",int('100',16),0,32,30)
]

# Generate getters and setters based on _data_inspector_props
for (name, addr, s, w, f) in _awgn_channel_props:
    setattr(AWGNChannel, name, _create_mmio_property(name, addr, s, w, f))
    
    
class BitErrorRate(DefaultIP):
    def __init__(self, description):
        super().__init__(description=description)
        
    def reset(self):
        self.bit_count_reset = 1
        self.bit_count_reset = 0
        
    def get_bit_count(self):
        return self.bit_count
    
    def get_bit_error(self):
        if self.bit_count == 0:
            return 0
        else:
            return self.bit_error
    
    def get_ber(self):
        if self.bit_count == 0:
            return 0
        else:
            return self.bit_error / (self.bit_count * 8)
        
    bindto = ['strathsdr.org:rfsoc_sdfec:ber:1.3']

# LUT of property addresses for our data-driven properties
_ber_props = [
    ("bit_error",    int('100',16),0,32,0),
    ("bit_count",    int('104',16),0,32,0),
    ("fifo_num",    int('108',16),0,32,0),
    ("bit_count_reset",    int('110',16),0,32,0),
    ("length", int('114',16),0,32,0)
]

# Generate getters and setters based on _data_inspector_props
for (name, addr, s, w, f) in _ber_props:
    setattr(BitErrorRate, name, _create_mmio_property(name, addr, s, w, f))
    

class QAMMapping(DefaultIP):
    def __init__(self, description):
        super().__init__(description=description)
        
    def reset_ip(self):
        self.reset = 1
        self.reset = 0
        
    def setup(self,n):
        self.valid = int(n % 8 > 0)
        
    bindto = ['strathsdr.org:rfsoc_sdfec:qam_mapping:1.3']

# LUT of property addresses for our data-driven properties
_qam_mapping_props = [
    ("reset",int('0',16),0,32,0),
    ("valid",    int('100',16),0,32,0)
]

# Generate getters and setters based on _data_inspector_props
for (name, addr, s, w, f) in _qam_mapping_props:
    setattr(QAMMapping, name, _create_mmio_property(name, addr, s, w, f))
    

class RandomNumberGenerator(DefaultIP):
    def __init__(self, description):
        super().__init__(description=description)
        
    def reset_ip(self):
        self.reset = 1
        self.reset = 0
        
    def start(self):
        self.enable = 1
        self.enable = 0
        
    def set_signal_length(self, length):
        self.compare = length
       
    bindto = ['strathsdr.org:rfsoc_sdfec:Random_Number_Gen:1.0']

# LUT of property addresses for our data-driven properties
_random_number_gen_props = [
    ("reset",int('0',16),0,32,0),
    ("enable",    int('100',16),0,32,0),
    ("compare",    int('104',16),0,32,0)
]

# Generate getters and setters based on _data_inspector_props
for (name, addr, s, w, f) in _random_number_gen_props:
    setattr(RandomNumberGenerator, name, _create_mmio_property(name, addr, s, w, f))
    
    
class SDFecControl(DefaultIP):
    def __init__(self, description):
        super().__init__(description=description)
        self.len = 0
        
    def reset_ip(self):
        self.reset = 1
        self.reset = 0
        
    def set(self, ctrl, length):
        self.ctrl = ctrl
        self.length = length
        self.len = length
        
    bindto = ['strathsdr.org:rfsoc_sdfec:Fec_Ctrl:1.2']

# LUT of property addresses for our data-driven properties
_fec_ctrl_props = [
    ("reset",   int('0',16),0,32,0),
    ("ctrl",    int('100',16),0,32,0),
    ("length",  int('104',16),0,32,0)
]

# Generate getters and setters based on _data_inspector_props
for (name, addr, s, w, f) in _fec_ctrl_props:
    setattr(SDFecControl, name, _create_mmio_property(name, addr, s, w, f))
    

class SoftDemodulation(DefaultIP):
    def __init__(self, description):
        super().__init__(description=description)  
        
    def reset_ip(self):
        self.reset = 1
        self.reset = 0
    
    def set_scaling(self, variance, scale):
        llr_scale = 1
        self.llr_scale = int(np.uint32(llr_scale*pow(2,12))) # <0:32:12>
        
    bindto = ['strathsdr.org:rfsoc_sdfec:soft_demodulation:1.5']

# LUT of property addresses for our data-driven properties
_soft_demodulation_props = [
    ("reset",int('0',16),0,32,0),
    ("llr_scale",int('100',16),0,32,12)
]

# Generate getters and setters based on _data_inspector_props
for (name, addr, s, w, f) in _soft_demodulation_props:
    setattr(SoftDemodulation, name, _create_mmio_property(name, addr, s, w, f))