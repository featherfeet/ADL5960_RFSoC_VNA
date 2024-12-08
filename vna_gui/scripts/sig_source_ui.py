import ipywidgets as widgets
from IPython.display import display, clear_output
import sig_source
from sig_source import SigSource  # Assuming SigSource is in another module
import threading
import time


class SignalSourceUI:

    def __init__(self, mmio_spi_controller=1):
        # Initialize signal source
        self.source = SigSource(mmio_spi_controller=mmio_spi_controller)

        # Global control variable for threading
        self.running = False

        # Create headers
        self.general_header = widgets.HTML(value="<h3>Source Configuration</h3>")
        self.mode_header = widgets.HTML(value="<h3>Output Mode</h3>")
        
        # Create widgets
        self.start_stop_slider = widgets.FloatRangeSlider(
            value=[self.source.lowest_freq / (10**6), self.source.highest_freq / (10**6)],
            min=self.source.lowest_freq / (10**6),
            max=self.source.highest_freq / (10**6),
            step=1,
            continuous_update=False,
            orientation='horizontal',
            readout=True,
            readout_format='1.0f',
            layout=widgets.Layout(width='500px')
        )
        self.center_slider = widgets.FloatSlider(
            value=self.source.center_freq / (10**6),
            min=self.source.lowest_freq / (10**6),
            max=self.source.highest_freq / (10**6),
            step=1
        )
        self.span_slider = widgets.FloatSlider(
            value=((self.source.highest_freq - self.source.lowest_freq) / 2) / 10**6,
            min=1,
            max=((self.source.highest_freq - self.source.lowest_freq)) / 10**6,
            step=1
        )
        self.resolution_slider = widgets.FloatSlider(value=100, min=0, max=1000, step=1)
        self.calc_selection = widgets.ToggleButtons(
            options=['Start-Stop', 'Center-Span'],
            description='Calculate Based On:',
            disabled=False,
            button_style=''
        )
        self.update_button = widgets.Button(description="Update Wave")

        self.mode_toggle = widgets.ToggleButtons(
            options=['User Input Frequency', 'Sweep Freq'],
            description='Mode:',
            layout=widgets.Layout(min_width='400px', max_width='1000px')
        )
        self.user_freq_input = widgets.FloatText(
            description='Freq (MHz):',
            value=100,
            layout=widgets.Layout(width='300px')
        )
        self.set_freq_button = widgets.Button(
            description="Set Frequency",
            layout=widgets.Layout(width='150px')
        )
        self.generate_freq_button = widgets.Button(
            description="Generate Frequency Points",
            layout=widgets.Layout(width='200px')
        )
        self.out = widgets.Output(layout=widgets.Layout(width='500px'))

        # Initial widget visibility
        self.user_freq_input.layout.visibility = "visible"
        self.set_freq_button.layout.visibility = "visible"
        self.generate_freq_button.layout.visibility = "hidden"

        # Add event listeners
        self.update_button.on_click(self.update_function)
        self.set_freq_button.on_click(self.set_user_frequency)
        self.generate_freq_button.on_click(self.generate_freq_points)
        self.mode_toggle.observe(self.on_mode_toggle_change, names='value')

        # Create layout
        self.layout = self.create_layout()

    def create_layout(self):
        """
        Creates the layout for the UI components.
        """
        source_setup_layout = widgets.VBox([
            self.general_header,
            widgets.VBox([widgets.Label(value="Start Stop Slider (MHz)"), self.start_stop_slider]),
            widgets.HBox([
                widgets.VBox([widgets.Label(value="Center Slider (MHz)"), self.center_slider]),
                widgets.VBox([widgets.Label("Span Slider (Hz)"), self.span_slider])
            ]),
            widgets.VBox([widgets.Label(value="Points per Sweep"), self.resolution_slider]),
            self.calc_selection,
            self.update_button,
            self.mode_header,
            self.mode_toggle,
            widgets.HBox([self.user_freq_input, self.set_freq_button]),
            self.generate_freq_button,
            self.out
        ], layout=widgets.Layout(padding='5px 0', margin='0', width = '90%'))

        return source_setup_layout

    def set_user_frequency(self, change=None):
        """
        Set frequency based on user input.
        """
        with self.out:
            clear_output()
            try:
                if self.mode_toggle.value == "User Input Frequency":
                    frequency = self.user_freq_input.value
                    self.source.set_active()
                    self.source.set_frequency(frequency * 10**6)
                    print(f"Set frequency to {frequency} MHz.")
                else:
                    print(f"Wrong Mode. Follow automatic frequency.")
            except Exception as e:
                print(f"Error setting frequency: {e}")

    def generate_freq_points(self, change=None):
        """
        Generate frequency points and sweep.
        """
        with self.out:
            clear_output()
            try:
                if self.mode_toggle.value == "Sweep Freq":
                    frequency_list = self.source.generate_freq_points()

                    def freq_update_loop():
                        while True:
                            if not self.running:
                                break
                            self.source.set_next_freq()
                            #with self.out:
                                #clear_output(wait=True)
                            print(f"Setting frequency to {self.source.get_current_freq():.2f} Hz")
                            #time.sleep(0.3)

                    # Start the loop in a new thread
                    self.running = True
                    thread = threading.Thread(target=freq_update_loop, daemon=True)
                    thread.start()
                else:
                    print("Wrong Mode. Follow user input frequency.")
            except Exception as e:
                print(f"Error generating frequency points: {e}")

    
    def on_mode_toggle_change(self, change):
        """
        Handle mode changes to stop running threads and adjust visibility.
        """
        self.running = False
        if self.mode_toggle.value == "User Input Frequency":
            self.user_freq_input.layout.visibility = "visible"
            self.set_freq_button.layout.visibility = "visible"
            self.generate_freq_button.layout.visibility = "hidden"
            with self.out:
                clear_output()
                print("Mode changed to User Input Frequency.")
        else:
            self.user_freq_input.layout.visibility = "hidden"
            self.set_freq_button.layout.visibility = "hidden"
            self.generate_freq_button.layout.visibility = "visible"
            with self.out:
                clear_output()
                print("Mode changed to Generate Points.")

    def update_function(self, change=None):
        """
        Update the source parameters based on widget values.
        """
        with self.out:
            clear_output()
            try:
                if self.calc_selection.value == "Start-Stop":
                    self.source.update_parameters(
                        start=self.start_stop_slider.value[0] * 10**6,
                        stop=self.start_stop_slider.value[1] * 10**6,
                        resolution=self.resolution_slider.value
                    )
                elif self.calc_selection.value == "Center-Span":
                    self.source.update_parameters(
                        center=self.center_slider.value * 10**6,
                        span=self.span_slider.value * 10**6,
                        resolution=self.resolution_slider.value
                    )
                self.start_stop_slider.value = (self.source.start / 10**6, self.source.stop / 10**6)
                self.center_slider.value = self.source.center / 10**6
                self.span_slider.value = self.source.span / 10**6
            except Exception as e:
                print(f"Error: {e}")

    def display(self):
        """
        Display the layout in the notebook.
        """
        display(self.layout)


# If running as a script, initialize and display the UI
if __name__ == "__main__":
    ui = SignalSourceUI()
    ui.display()
