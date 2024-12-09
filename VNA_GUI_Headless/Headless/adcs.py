import xrfdc
from pynq import allocate
import numpy as np

class ADCs:
    def __init__(self, rfdc, dma_interface):
        """
        Set up RFSoC ADCs.
        rfdc - Pynq handle for RF data converter object.
        dma_interface - Pynq handle for DMA interface used for pulling raw ADC samples.
        """
        self.rfdc = rfdc
        self.dma_interface = dma_interface

        # Turn off Automatic Gain Control (AGC) on all 4 ADCs
        for adc_tile in (self.rfdc.adc_tiles[0], self.rfdc.adc_tiles[2]):
            for block in adc_tile.blocks[:2]:
                for threshold in block.thresholds:
                    threshold.Settings["ThresholdMode"] = xrfdc.TRSHD_OFF

    def read_adcs(self, length = 10000 * 4):
        # Trigger the DMA transfer and wait for the result
        out_buffer = allocate(length, dtype = np.int32)
        # Trigger the DMA transfer and wait for the result
        self.dma_interface.recvchannel.transfer(out_buffer)
        self.dma_interface.recvchannel.wait()

        out_buffer_np = np.array(out_buffer, dtype = np.int32)

        # Split buffers and process data
        out_adc0 = out_buffer_np[0::4]
        out_adc1 = out_buffer_np[1::4]
        out_adc2 = out_buffer_np[2::4]
        out_adc3 = out_buffer_np[3::4]

        return out_adc0, out_adc1, out_adc2, out_adc3
