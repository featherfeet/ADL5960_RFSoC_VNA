'''
SPI Controller to talk with ADL5960

VNA Project
Fall 2024
'''

import time

MMIO_REGISTERS = {"TRIGGER": 0x14, "SPI_DATA_IN": 0x08, "SPI_DATA_OUT": 0x0C}

class ADL5960:
    soft_reset = 0x0000_81
    device_shutdown = 0x0002_02
    un_device_shutdown = 0x0002_00
    lo_config = 0x0020_01
    set_IF_filter = 0x0025_00
    set_rgain = 0x0023_00
    set_fgain = 0x0024_00
    
    def __init__(self, mmio_spi_controller, fgain = 12, rgain = 12):
        """
        mmio_spi_controller is a Pynq handle for an MMIO going to our custom SPI controller.
        initial_register_file is a path to a register map file exported from TICS-PRO for the default setup of the chip.
        """
        self.mmio_spi_controller = mmio_spi_controller
        self.softreset()
        self._spi_transaction(self.lo_config)
        self._spi_transaction(self.set_IF_filter)
        if int(fgain) < 0 or int(fgain) > 48:
            raise ValueError("FGAIN must be between 0 and 48 dB.")
        if int(rgain) < 0 or int(rgain) > 48:
            raise ValueError("RGAIN must be between 0 and 48 dB.")
        self.fgain = fgain
        self.rgain = rgain
        print(self._spi_transaction(self.set_rgain | int(fgain)))
        print(self._spi_transaction(self.set_fgain | int(rgain)))
        
    def _spi_transaction(self, command):
        self.mmio_spi_controller.write(MMIO_REGISTERS["SPI_DATA_OUT"], command)  
        self.mmio_spi_controller.write(MMIO_REGISTERS["TRIGGER"], 0x0)
        time.sleep(0.1)
        return self.mmio_spi_controller.read(MMIO_REGISTERS["SPI_DATA_IN"])
    
    def read_register(self,command):
        self.mmio_spi_controller.write(MMIO_REGISTERS["SPI_DATA_OUT"], (command+0x8000_00)) #add to command so that read bit is 1  
        self.mmio_spi_controller.write(MMIO_REGISTERS["TRIGGER"], 0x0)
        time.sleep(0.1)
        return self.mmio_spi_controller.read(MMIO_REGISTERS["SPI_DATA_IN"])
    
    def shutdown(self):
        self._spi_transaction(self.device_shutdown)
    
    def softreset(self):
        self._spi_transaction(self.soft_reset)
        
    def unshutdown(self):
        self._spi_transaction(self.un_device_shutdown)
