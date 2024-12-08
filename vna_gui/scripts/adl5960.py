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
    set_rgain = 0x0023_0C
    set_fgain = 0x0024_0C
    
    def __init__(self, mmio_spi_controller):
        """
        mmio_spi_controller is a Pynq handle for an MMIO going to our custom SPI controller.
        initial_register_file is a path to a register map file exported from TICS-PRO for the default setup of the chip.
        """
        self.mmio_spi_controller = mmio_spi_controller
        self._spi_transaction(self.lo_config)
        self._spi_transaction(self.set_IF_filter)
        self._spi_transaction(self.set_rgain)
        self._spi_transaction(self.set_fgain)
        
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