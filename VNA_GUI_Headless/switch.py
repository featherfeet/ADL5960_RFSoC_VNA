class Switch:
    def __init__(self, gpio_pin):
        """
        Control RF switch.
        gpio_pin - Pynq handle for GPIO pin object.
        """
        self.gpio_pin = gpio_pin

    def setPort1Active(self):
        self.gpio_pin.write(0)

    def setPort2Active(self):
        self.gpio_pin.write(1)
