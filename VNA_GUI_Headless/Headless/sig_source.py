'''
Initalize a signal source for VNA

Stores the signal source settings:
- Start Frequency
- Stop Frequency
- Resolution
- Current frequency
- Sweep State

VNA Project
Fall 2024
'''

import numpy as np
from lmx2595 import LMX2595

class SigSource:
    #System Specs
    lowest_freq = 100 #10Mhz 
    highest_freq = 20000 #20Ghz 
    center_freq = ((highest_freq -lowest_freq)/2)
    start = 0
    stop = 0
    center = 0
    span = 100
    resolution = 100
    active = False

    freq_points = []
    current_freq_counter = 0
    current_freq = 0

    def __init__(self, start = lowest_freq, stop = highest_freq, center = center_freq, mmio_spi_controller = 0, span = span, resolution = resolution, active = active):
        """
        Initializes the FrequencyRange with either:
        - start and stop frequencies, or
        - center frequency and span.

        Parameters:
        - start (float, optional): The starting frequency in MHz.
        - stop (float, optional): The stopping frequency in MHz.
        - center (float, optional): The center frequency in MHz.
        - span (float, optional): The frequency span in MHz.
        - resolution (float): The resolution bandwidth in MHz
        - active (bool): Whether this frequency range is active or not (default True).
        
        At least either (start and stop) or (center and span) must be provided.
        """
        
        self.lmx = LMX2595(mmio_spi_controller = mmio_spi_controller) #initilaize the source control object 

        # Validation to ensure either (start, stop) or (center, span) is provided
        if (start is not None and stop is not None):
            self.start = start
            self.stop = stop
            self.center = (start + stop) / 2
            self.span = stop - start
        elif (center is not None and span is not None):
            self.center = center
            self.span = span
            self.start = center - span / 2
            self.stop = center + span / 2
        else:
            raise ValueError("You must provide either (start and stop) or (center and span).")
        
        # Validate that the frequencies and span are logical
        if self.start >= self.stop:
            raise ValueError("Start frequency must be less than stop frequency.")
        #Validate that they fit within the right range
        if self.start < self.lowest_freq:
            print("WARNING: Start frequency is below " + str(self.lowest_freq))
            self.start = self.lowest_freq
        if self.stop > self.highest_freq:
            print("WARNING: Stop frequency is above " + str(self.highest_freq))
            self.stop = self.highest_freq
        
        # Initialize additional attributes
        self.resolution = resolution
        self.active = active
        
        #Generate the initial frequency points 
        self.generate_freq_points(set_internal = True)

        print("Initializing signal source with Start Frequency: {} Stop Frequency: {} Resolution: {}".format(self.start, self.stop, self.resolution))

    def update_parameters(self, start=None, stop=None, center=None, span=None, resolution = None, single_freq = None):
        """
        Updates the frequency range parameters. Accepts either:
        - start and stop frequencies, or
        - center frequency and span.
        
        Parameters:
        - start (float, optional): The starting frequency in Hz.
        - stop (float, optional): The stopping frequency in Hz.
        - center (float, optional): The center frequency in Hz.
        - span (float, optional): The frequency span in Hz.
        """
        
        flag = "NONE"

        #Update the parameters if relavent 
        if (start is not None and start != self.start):
            self.start = start
            flag = "START_END"
        if (stop is not None and stop != self.stop):
            self.stop = stop
            flag = "START_END"
        if (center is not None and center != self.center):
            self.center = center
            flag = "CENTER_SPAN"
        if (span is not None and span != self.span):
            self.span = span
            flag = "CENTER_SPAN"
        if (single_freq is not None):
            self.single_freq = single_freq
            flag = "SINGLE_FREQ"
        if (resolution is not None and resolution != self.resolution):
            self.resolution = resolution

        #Update all the respective parameters 
        if (flag == "START_END"):
            self.center = (self.stop + self.start) / 2 
            self.span = self.stop - self.start
        elif (flag == "CENTER_SPAN"):
            self.start = self.center - (self.span / 2)
            self.stop = self.center + (self.span / 2)
        elif (flag == "SINGLE_FREQ"):
            self.start = single_freq
            self.stop = single_freq
            self.center = single_freq
            self.span = 0
            self.resolution = 1

        #Validate all parameters fit in the right range
        if (self.start > self.stop):
            raise ValueError("Start frequency must be less or equal to stop frequency.")
        if self.start < self.lowest_freq:
                print("WARNING: Start frequency is below " + str(self.lowest_freq) + " Setting to the lowest possible frequency.")
                self.start = self.lowest_freq
        if self.stop > self.highest_freq:
                print("WARNING: Stop frequency is above " + str(self.highest_freq) + " Setting to the highest possible frequency.")
                self.stop = self.highest_freq 
        if self.resolution < 1:
            raise ValueError("The resolution must be greater than 1.")

        #Generate the initial frequency points 
        self.generate_freq_points(set_internal = True)
        
        print("Signal Source with Start Frequency: {} Stop Frequency: {} Resolution: {}".format(self.start, self.stop, self.resolution))
        
    def generate_freq_points(self, set_internal = True):
        '''
        Generates a list of frequency points for the start/stop and depending on the number of points requested
        '''
        if set_internal:
            if (self.start == self.stop): #if set to a single frequency, return a list with one frequency
                self.freq_points = [self.start]
            else:
                self.freq_points = np.linspace(self.start, self.stop, int(self.resolution)).tolist()
            self.current_freq_counter = 0 #Reset the current frequency counter
        return self.freq_points

    def set_active(self):
        #Will only push to set_frequency if active
        self.active = True
    
    def set_inactive(self):
        #Will not push to set_frequency
        self.active = False
    
    def set_frequency(self, freq):
        '''
        Calls the source signal object to set the frequency function
        Only if active
        '''
        if self.active:
            self.current_freq = freq
            self.lmx.setOutputFrequencyA(self.current_freq)
   
    def set_next_freq(self, start = False):
        #Handling the index, stored in current_freq_counter
        if (self.start == self.stop):
            set_freq = self.start
            self.current_freq_counter = 0
        else: 
            if (start):
                #If starting, then set the frequency the start frequency
                self.current_freq_counter = 0
            else:
                #If not starting, then increment frequency counter 
                self.current_freq_counter += 1 
                if (self.current_freq_counter >= len(self.freq_points)): #wrap around function 
                    self.current_freq_counter = 0
            set_freq = self.freq_points[self.current_freq_counter]
        #Setting the output frequency to that number
        self.set_frequency(set_freq)
        return set_freq
            
    def get_current_index(self):
        return self.current_freq_counter
    
    def get_current_freq(self):
        return self.freq_points[self.current_freq_counter] #Returns the current frequency that the class is outputting

    def get_parameters(self):
        #Returns the start, stop, center, span parameters in a list
        #Done for ease of access, otherwise just access object.parameter 
        return [self.start, self.stop, self.center, self.span]
