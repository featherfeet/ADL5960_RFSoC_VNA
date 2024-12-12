import math
import numpy as np
from pynq import allocate

class DSPAccelerator:
    def __init__(self, dma_interface, name = ""):
        """
        Set up RFSoC ADCs.
        dma_interface - Pynq handle for DMA interface used for pulling raw ADC samples.
        """
        self.dma_interface = dma_interface
        self.name = name

    def read_s_parameters(self):
        # Trigger the DMA transfer and wait for the result
        out_buffer = allocate(4, dtype = np.uint32)
        # Trigger the DMA transfer and wait for the result
        self.dma_interface.recvchannel.transfer(out_buffer)
        self.dma_interface.recvchannel.wait()

        out_buffer_np = np.array(out_buffer, dtype = np.uint32)
        print(f"{self.name}: {hex(out_buffer_np[0])}, {hex(out_buffer_np[1])}")

        magnitude = np.float64(out_buffer_np[0]) / (2 ** 16)
        phase = np.float64(out_buffer_np[1]) / (2 ** 16) * 2 * math.pi

        return magnitude, phase
