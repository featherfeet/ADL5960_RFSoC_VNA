import ipywidgets as widgets
from IPython.display import display, clear_output
import sig_source
from sig_source import SigSource  # Assuming SigSource is in another module


class SignalSourceUI:
    def __init__(self, start=10000000, stop=20000000000, resolution=100.0, mmio_spi_controller = 1):
        # Initialize signal source
        # Passes the MMIO SPI Controller and resolutiosn down into the source
        self.source = SigSource(start=start, stop=stop, resolution=resolution, mmio_spi_controller=mmio_spi_controller)
        
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
        self.out = widgets.Output()
        
        # Create layout
        self.layout = self.create_layout()

        # Add event listener
        self.update_button.on_click(self.update_function)

    def create_layout(self):
        """
        Creates the layout for the UI components.
        """
        return widgets.VBox([
            widgets.VBox([widgets.Label(value="Start Stop Slider (MHz)"), self.start_stop_slider]),
            widgets.HBox([
                widgets.VBox([widgets.Label(value="Center Slider (MHz)"), self.center_slider]),
                widgets.VBox([widgets.Label("Span Slider (Hz)"), self.span_slider])
            ]),
            widgets.VBox([widgets.Label(value="Points per Sweep"), self.resolution_slider]),
            self.calc_selection,
            self.update_button,
            self.out
        ], layout=widgets.Layout(padding='20px 0'))

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

                # Update sliders to reflect the current source values
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
