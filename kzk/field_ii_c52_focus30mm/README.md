KZK Sim with Field II Input Pressure Fields
===========================================
Code for running KZK simulations using face pressure inputs generated from Field II.

### Methods
The pressure at a single position was calculated by convolving the impulse response of each C5-2 transducer element with the excitation pulse. The pressure waveform was oriented in space on the pressure plane with respect to the C5-2 transducer element geometry. Pressure waves were placed at locations corresponding to the element height and width. The time delays of each transducer element was formed by running Field II and grabbing the time delays at each element and using them to appropriate delay the pressure waveforms at each element.


### Results
A plot was made of pressure vs. time at the 0 mm elevational and 0 mm lateral positions for the experimentally measured C5-2 30 mm focus pressure data. This plot can be seen below.

![Center Trace Plot, C5-2 Expt. Measured Pressure Waveforms, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/kzk/field_ii_c52/c52_30mm_pressure_vs_time_centertrace.png)

There appears to be 7 excitation cycles based on the number of distinct peaks seen in the above plot. The time between peaks is approximately 0.42 μs, corresponding to a 2.36 MHz excitation. The sampling frequency for this pressure data was 500 MHz, which will be the same sampling rate used to make the Field II face pressure inputs. The main excitation pressure waveform appeared to last about 3 μs, ranging from 7 μs to 10 μs. For a 500 MHz sampling rate, there will be about 1500 samples for a 3 μs excitation. Thus, a 1500 sample, 7 cycle sine wave with a frequency of 2.36 MHz was generated and used as the excitation waveform. 

The impulse response for the C5-2 was assumed to be Gaussian-weighted with a center frequency of 3 MHz and a 0.7 fractional bandwidth. The same sampling frequency (500 MHz) as the sine wave was used to create this impulse response.

Finally, the excitation wave was convolved with the impulse response of the C5-2 to generate the final pressure waveform. The excitation wave, impulse response, and pressure waveform can be seen in the figure below.

![Synthesized Pressure Waveform, C5-2, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/kzk/field_ii_c52/c52_30mm_synthetic_press_wave.png)

The C5-2 transducer parameters were modeled using Field II (with 30 mm focus and F/2.8) and the C5-2 element dimensions found in `c52.m` in the `/probes/fem/` repository. A plot of the mathematical and physical element locations can be found below. The pressure field w/o time delays was made by placing a pressure waveform at approximately each mathematical element location.

![Physical and Mathematical Element Locations, C5-2, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/kzk/field_ii_c52/c52_30mm_phys_math_elem_locs.png)

The intensity field was constructed by taking the sum of the squares of the pressure waveform through time at each location. A plot of the intensity field can be seen in the figure below.

![Intensity Field, C5-2, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/kzk/field_ii_c52/c52_30mm_intensity_plane.png)

The element time delays were also calculated using Field II. A plot of these time delays can be seen below. A more negative delay meant that the signal occurred there earlier in time.

![Physical Element Time Delays, C5-2, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/kzk/field_ii_c52/c52_30mm_phys_elem_time_delays.png)

Additionally, there were extra time delays that occurred as a result of the curved geometry of the transducer probe. Unfortuantely, the depth locations did not occur at uniformly spaced locations on the plane, so they were interpolated to those grid locations. A scatterplot plot of the original 3D locations of each mathematical element as well as a plot of the interpolated depth values at each plane location can be seen below.

![3D Mathematical Element Locations, C5-2, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/kzk/field_ii_c52/c52_30mm_interp_elem_locations.png)

The mathematical elements were not located at the same depth, so signals with a more negative depth would need to travel a greater distance to reach the mesh. This distance was converted to time delays by assuming that the sound speed was 1540 m/s and calculating the corresponding time delay at each element. The time delay (s) was converted into time delay indices using the same sampling frequency as above (500 MHz). 
The time delays were applied to the pressure field, and the resulting time delays at each mathematical element can be seen below. Once again, more negative delay indicates that the signal occurred earlier in time.

![Pressure Field Time Delays, C5-2, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/kzk/field_ii_c52/c52_30mm_press_field_time_delays.png)

