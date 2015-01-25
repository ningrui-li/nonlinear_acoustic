Field II and KZK Comparison Scripts - 70 mm Focus
=================================================

This script uses the functions in `metrics` to compare the 70 mm focal depth Field II and KZK simulations.

#### Linear Simulation Comparison
`linear_compare.m` is a MATLAB script that compares the results of the Field II simulation with the results of the KZK simulation run in linear mode (β = 0). The results of the Field II simulation can be obtained by running the scripts in the `field` folder. The 70 mm focal depth simulation can be found at `/luscinia/nl91/nonlinear_acoustic/field/field_c52_70mm/dyna-I-f2.36-F2.8-FD0.070-a0.45.mat`. The results of the 70 mm focus linear KZK simulation can be found at `/luscinia/nl91/scratch/c52/focus70mm/quarter_symmetric/c52_70mm_qsymmetric_intensity_vals_linear.mat`.

All intensity values for each simulation were normalized by dividing by the maximum intensity in each field. The KZK intensity field results were quartered in order to be more comparable to the Field II simulations, which were run with the quarter symmetry assumption.

### Maximum Intensity
The maximum intensity for the Field II sim occurred at 0.00 cm in elevation position, 0.14 cm in lateral position, and 3.75 cm in depth position.

The maximum intensity for the linear KZK sim occured at 0.00 cm in elevation position, 0.00 cm in lateral position, and 6.40 cm in depth position.

### Center Trace Plot
The center trace plot for the two sims can be seen below.

![Center Trace Plot, Linear KZK and Field II Sims, 70 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/comparisons/focus70mm/field_kzk_centertrace_c52_70mm.png)

The intensity was plotted with respect to depth for each sim along the 0 cm lateral position and 0 cm elevational position axis. The intensity was then re-normalized along this axis.

