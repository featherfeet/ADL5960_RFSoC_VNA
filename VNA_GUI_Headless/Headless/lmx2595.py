'''
SPI Controller to talk with LMX2595

VNA Project
Fall 2024

Most code copied from TI Source code for LMX2595
'''

import time
import math
import bitstring

MMIO_REGISTERS = {"TRIGGER": 0x14, "SPI_DATA_IN": 0x08, "SPI_DATA_OUT": 0x0C}

class LMX2595:
    def __init__(self, mmio_spi_controller, initial_register_file = "./HexRegisterValues.txt"):
        """
        mmio_spi_controller is a Pynq handle for an MMIO going to our custom SPI controller.
        initial_register_file is a path to a register map file exported from TICS-PRO for the default setup of the chip.
        """
        self.mmio_spi_controller = mmio_spi_controller
        
        # HexRegisterValues is a tab-separated file of register number---> 16 with open("HexRegisterValues.txt") as regmap_file:s like "R78" and hex values like 0xABCD. The hex values contain the register number, which we remove.
        with open(initial_register_file) as regmap_file:
            regmap_text = regmap_file.read()
            regmap_lines = regmap_text.split('\n')
            regmap_lines.remove('')
            self.regmap = {}
            for line in regmap_lines:
                register, value = line.split('\t')
                value = bitstring.BitArray(int = int(value, 16), length = 24)
                value = value[8:] # Remove R/W and address bits from register value.
                self.regmap[int(register[1:])] = value
        
        self._write_register(0, 0b0010010100011110) # RESET
        for register in range(78, -1, -1):
            self._write_register(register, self.regmap[register])
        self._write_register(0, 0b0010010100011100) # Set FCAL_EN = 1 again
        
        self.Fosc_FREQ = 100 # 100 MHz reference
        print("Initalized source")
    
    def _spi_transaction(self, command):
        self.mmio_spi_controller.write(MMIO_REGISTERS["SPI_DATA_OUT"], command)  
        self.mmio_spi_controller.write(MMIO_REGISTERS["TRIGGER"], 0x0)
        time.sleep(2.5e-3)
        return self.mmio_spi_controller.read(MMIO_REGISTERS["SPI_DATA_IN"])
    
    def _write_register(self, address, data):
        command = bitstring.BitArray(length = 24)
        command[0] = 0 # R/W bit
        command[1:8] = address
        command[8:] = data
        return self._spi_transaction(command.u)
    
    def _read_register(self, address):
        command = bitstring.BitArray(length = 24)
        command[0] = 1 # R/W bit
        command[1:8] = address
        command[8:] = 0 # Don't care
        return self._spi_transaction(command.u)

    def _set_register_bits(self, register, start_bit, end_bit, value):
        """
        Send a SPI transaction that changes the inclusive range [start_bit, end_bit] in register to value. Bits are indexed with 0 as the LSB (see the register map in TI datasheet).
        """
        self.regmap[register][16 - start_bit - 1:16 - end_bit] = value
        self._write_register(register, self.regmap[register])
    
    def _get_register_bits(self, register, start_bit, end_bit):
        return self.regmap[register][16 - start_bit - 1:16 - end_bit]
    
    def _set_outa_mux(self, value):
        self._set_register_bits(45, 12, 11, value)
    
    def _get_outa_mux(self):
        return self._get_register_bits(45, 12, 11).u
    
    def _get_outb_mux(self):
        return self._get_register_bits(46, 1, 0).u
    
    def _set_vco2x_en(self, value):
        self._set_register_bits(27, 0, 0, value)
    
    def _set_chdiv(self, value):
        self._set_register_bits(75, 10, 6, value)
    
    def _get_chdiv(self):
        return self._get_register_bits(75, 10, 6).u
    
    def _get_osc_2x(self):
        return self._get_register_bits(9, 12, 12).u
    
    def _get_pll_den(self):
        higher_bits = self._get_register_bits(38, 15, 0)
        lower_bits = self._get_register_bits(39, 15, 0)
        pll_den = bitstring.BitArray(length = 32)
        pll_den[0:16] = higher_bits
        pll_den[16:] = lower_bits
        return pll_den.i
    
    def _set_pll_den(self, value):
        value = bitstring.BitArray(int = value, length = 32)
        self._set_register_bits(38, 15, 0, value[0:16])
        self._set_register_bits(39, 15, 0, value[16:])
        
    def _set_pll_num(self, value):
        value = bitstring.BitArray(int = value, length = 32)
        self._set_register_bits(42, 15, 0, value[0:16])
        self._set_register_bits(43, 15, 0, value[16:])
    
    def _get_pll_num(self):
        value = bitstring.BitArray(length = 32)
        value[0:16] = self._get_register_bits(42, 15, 0)
        value[16:] = self._get_register_bits(43, 15, 0)
        return value.i
        
    def _get_pll_r_pre(self):
        return self._get_register_bits(12, 11, 0).u
    
    def _get_mult(self):
        return self._get_register_bits(10, 11, 7).u
    
    def _get_pll_r(self):
        return self._get_register_bits(11, 11, 4).u
    
    def _set_pll_n(self, value):
        #print(f"Setting PLL_N to {value}")
        value = bitstring.BitArray(int = value, length = 19)
        self._set_register_bits(34, 2, 0, value[0:3])
        self._set_register_bits(36, 15, 0, value[3:])
    
    def _get_pll_n(self):
        value = bitstring.BitArray(length = 19)
        value[0:3] = self._get_register_bits(34, 2, 0)
        value[3:] = self._get_register_bits(36, 15, 0)
        return value.i
    
    def _get_powerdown(self):
        return self._get_register_bits(0, 0, 0).u

    def _get_reset(self):
        return self._get_register_bits(0, 1, 1).u
    
    def _get_cpg(self):
        return self._get_register_bits(14, 6, 4).u
    
    def _get_seg1_en(self):
        return self._get_register_bits(31, 14, 14).u
    
    def _set_fcal_en(self, value):
        self._set_register_bits(0, 3, 3, value)
    
    def _calculate_chandiv(self, Index):
        i=int(Index)
        x=1
        if (i==0):
            x=2
        elif (i==1):
            x=4  
        elif (i==2):
            x=6  
        elif (i==3):
            x=8  
        elif (i==4):
            x=12 
        elif (i==5):
            x=16
        elif (i==6):
            x=24 
        elif (i==7):
            x=32 
        elif (i==8):
            x=48 
        elif (i==9):
            x=64 
        elif (i==10):
            x=72 
        elif (i==11):
            x=96
        elif (i==12):
            x=128
        elif (i==13):
            x=192
        elif (i==14):
            x=256
        elif (i==15):
            x=384
        elif (i==16):
            x=512
        elif (i==17):
            x=768

        return x
    
    def _update_n_divider(self):
        Fvco = self.Fvco_FREQ
        Fden = self._get_pll_den()
        #print(f"Fvco: {Fvco}")
        #print(f"Fden: {Fden}")
        if Fden < 1:
            Fden = 1
            self._set_pll_den(1)

        #Fpd = self.Fpd_FREQ
        #if (Fpd<0.0000001):
        #    Fpd_FREQ.dValue=1
        #    Fpd=1

        PreR = self._get_pll_r_pre()
        #print(f"PreR: {PreR}")
        if PreR < 1:
            PreR = 1
        #print(f"OSC_2x: {self._get_osc_2x()}")
        #print(f"MULT: {self._get_mult()}")
        MultOut = self.Fosc_FREQ * (self._get_osc_2x() + 1) * self._get_mult() / PreR
        if MultOut < 0.000001:
            MultOut = self.Fosc_FREQ
        #print(f"MultOut: {MultOut}")

        Rdiv = self._get_pll_r()
        #print(f"Rdiv: {Rdiv}")
        if Rdiv < 1:
            Rdiv = 1       

        #   Note, do not use Fpd_Freq as it has been rounded off and can cause an infinite loop
        flexINCLUDED_DIVIDE = 1 # Unclear why this is always 1 in the GUI, but as far as I can tell it is.
        FracN = Rdiv * Fvco / (MultOut * flexINCLUDED_DIVIDE)
        N = math.floor(FracN)
        self._set_pll_n(N)
        self._set_pll_num(round(Fden * (FracN - N)))
        
    def _update_vco_frequency(self):
        Fden = self._get_pll_den()
        TotalR = self._get_pll_r_pre() * self._get_pll_r()
        if TotalR < 1:
            TotalR = 1
        TotalMult = (1 + self._get_osc_2x()) * self._get_mult()
        if (TotalMult < 1):
            TotalMult = 1
        #   Be cautious to use calculations that do not cause round-off error problems or VCO frequency
        if Fden < 1:
            Fden = 1
        TotalN = 1.0 * self._get_pll_n() + self._get_pll_num() * 1.0 / Fden
        flexINCLUDED_DIVIDE = 1
        self.Fvco_FREQ = round(TotalMult * flexINCLUDED_DIVIDE * TotalN * self.Fosc_FREQ / TotalR, 10)

        #self._update_vco_gain()
        #UpdateDistribution()

        """
    def _update_current(self):
        Current = -1
        if self._get_powerdown() == 1:
            Current = 4.1
        elif self._get_reset() == 1:
            Current = 160.9
        else:
            #   Core Current Outputs Off, No Channel Divider, 100 MHz Fpd, VCO Core 7 @ 14 GHz
            if (self._get_cpg() == 0):
                Current = 236.6
            elif (self._get_cpg() == 1) or (self._get_cpg() == 2):
                Current = 242.3
            elif (self._get_cpg() == 3):
                Current = 244.5
            elif (self._get_cpg() == 4):
                Current = 241.1
            elif (self._get_cpg() == 5) or (self._get_cpg() == 6):
                Current = 243.5
            else:
                Current = 245.7

            #   Modify Based on VCO 
            if (self.Fvco_FREQ<8450):
                Current=Current+80.6-67.2
            elif (self.Fvco_FREQ<9700):
                Current=Current+81.3-67.2
            elif (self.Fvco_FREQ<10750):
                Current=Current+78.9-67.2
            elif (self.Fvco_FREQ<12050):
                Current=Current+88.7-67.2
            elif (self.Fvco_FREQ<12850):
                Current=Current+70.5-67.2
            elif (self.Fvco_FREQ<13750):
                Current=Current+76.9-67.2
            else:
                Current=Current+67.2-67.2     


            #   Modify Based on Input Path   
            if (self._get_osc_2x()==1):
                Current=Current+2.1

            if (self._get_mult()>1):
                Current=Current+5.4

            #   MUXout Impact
            OUTA_MUX = self._get_outa_mux()
            OUTB_MUX = self._get_outb_mux()
            if (OUTA_MUX==0):
                if (OUTB_MUX==0):
                    Current=Current+31
                elif (OUTB_MUX==1):
                    Current=Current+39.1
                elif (OUTB_MUX==2):
                    Current=Current+51
                elif (OUTB_MUX==3):
                    Current=Current+47     
            elif (OUTA_MUX==1):     
                if (OUTB_MUX==0):
                    Current=Current+39.1
                elif (OUTB_MUX==2):
                    Current=Current+46.7
                elif (OUTB_MUX==3):
                    Current=Current+32.7
            elif (OUTA_MUX==2):     
                if (OUTB_MUX==0):
                    Current=Current+51.1
                elif (OUTB_MUX==1):
                    Current=Current+56.8
                elif (OUTB_MUX==2):
                    Current=Current-21
                elif (OUTB_MUX==3):
                    Current=Current+52  
            else:
                if (OUTB_MUX.iValue==0):
                    Current=Current+46.7
                else:
                    Current=Current+52.4

            #   Give an 8 mA bonus for unclicking SEG1_EN
            if (self._get_seg1_en() == 0) and ((OUTA_MUX % 3 == 0) or (OUTB_MUX <> 1)):
                Current=Current-8
            #   VCO2X Impact
            if (OUTA_MUX.iValue==2):
                Current=Current+60

            #   Output
            Min=58
            Max=109.6

            if (OUTA_PD.iValue==0):
                PWR=OUTA_PWR.iValue
                if (PWR>31):
                    PWR=PWR-16
                Current=Current + Min + PWR*(Max-Min)/47

            if (OUTB_PD.iValue==0):
                PWR=OUTB_PWR.iValue
                if (PWR>31):
                    PWR=PWR-16
                Current=Current + Min + PWR*(Max-Min)/47

            if (OUTA_PD.iValue==0) and (OUTB_PD.iValue==0):
                Current=Current-5

        flexCurrent.dValue=round(Current)
"""
        
    def setOutputFrequencyA(self, Fout):
        """
        Change the output frequency of the LMX2595 on output A. Fout is a floating-point value in MHz.
        """
        self.FoutA_FREQ = Fout
        #   Figure out if MUX Should be Changed
        if Fout > 15000:
            self._set_outa_mux(2)
            self._set_vco2x_en(1)
            self.outa_mux = 2
        elif Fout >= 7500:
            self._set_outa_mux(1)
            self._set_vco2x_en(0)
            self.outa_mux = 1
        elif Fout < 7500:
            self._set_outa_mux(0)
            self._set_vco2x_en(0)
            self.outa_mux = 0

        if self.outa_mux == 0:
            Divide = self._calculate_chandiv(self._get_chdiv())
            Fvco = Fout * Divide
            if (Fvco >= 7500) and (Fvco <= 15000) and ((Fvco <= 11500) or (Divide < 7)):
                self.Fvco_FREQ = round(Fvco,10)
            else:
                FoundMatch=0
                for i in range(0,18):
                    Divide = self._calculate_chandiv(i)
                    Fvco = Divide * Fout
                    if (Fvco >= 7500) and ((Fvco <= 11500) or (Divide < 7)):
                        self.Fvco_FREQ = round(Fvco, 10)
                        self._set_chdiv(i)
                        FoundMatch = 1
                        break

                if FoundMatch == 0:
                    self.Fvco_FREQ = 7500
                    self._set_chdiv(17)
                    self.FoutA_FREQ = 7500.0/768
                    raise ValueError(f"Failed to set frequency {Fout} MHz, defaulting to 7.5 GHz.")
        elif self.outa_mux == 2:
            self.Fvco_FREQ = round(self.FoutA_FREQ / 2, 10)
        else:
            self.Fvco_FREQ = round(self.FoutA_FREQ, 10)
            if self._get_chdiv() > 2 and self.Fvco_FREQ > 11500:
                self._set_chdiv(0)

        self._update_n_divider()
        self._update_vco_frequency()
        self._set_fcal_en(1)
        #UpdateVCOGain()
        #UpdateDistribution()
        #self._update_current()
        #UpdateCurrent()
