KZK Sim with Field II Input Pressure Fields
===========================================
Code for running KZK simulations using face pressure inputs generated from Field II.

### Methods
The pressure at a single position was calculated by convolving the impulse response of each C5-2 transducer element with the excitation pulse. The pressure waveform was oriented in space on the pressure plane with respect to the C5-2 transducer element geometry. Pressure waves were placed at locations corresponding to the element height and width. The time delays of each transducer element was formed by running Field II and grabbing the time delays at each element and using them to appropriate delay the pressure waveforms at each element.


### Results
A plot was made of pressure vs. time at the 0 mm elevational and 0 mm lateral positions for the experimentally measured C5-2 30 mm focus pressure data. This plot can be seen below.

![Center Trace Plot, C5-2 Expt. Measured Pressure Waveforms, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/kzk/field_ii_c52/c52_30mm_pressure_vs_time_centertrace.png)

There appears to be 7 excitation cycles based on the number of distinct peaks seen in the above plot.