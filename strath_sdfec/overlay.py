__author__ = "Lewis McLaughlin"
__organisation__ = "The Univeristy of Strathclyde"
__support__ = "https://github.com/strath-sdr/rfsoc_sdfec"

from pynq import Overlay
import os

class SdfecOverlay(Overlay):

    def __init__(self, bitfile_name=None, **kwargs):

        # Generate default bitfile name
        if bitfile_name is None:
            this_dir = os.path.dirname(__file__)
            bitfile_name = os.path.join(this_dir, 'strath_sdfec', 'bitstream', 'strath_sdfec.bit')
        elif bitfile_name == "hw_accel":
            this_dir = os.path.dirname(__file__)
            bitfile_name = os.path.join(this_dir, 'strath_sdfec_hw', 'bitstream', 'strath_sdfec_hw.bit')
            
        # Create Overlay
        super().__init__(bitfile_name, **kwargs)