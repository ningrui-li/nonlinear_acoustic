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

### Contour Planes
The contour plane plots for the Field II and KZK sims can be found below in each of the three planes (elevational, lateral, and depth).

##### Elevational Planes
Contour plot slices at elevational positions of -0.14 cm, -0.06 cm, and 0.00 cm can be found below. These planes were chosen because the KZK sim had maximum normalized intensity at an elevational position of -0.14 cm, while the Field II sim had maximum normalized intensity at an elevational position of 0.00 cm.

 * Field II - Elevational Plane Contour Plots

![Elevational Plane Contour Plots, Field II Sim, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/comparisons/focus30mm/field2_30mm_elevational.png)

 * KZK - Elevational Plane Contour Plots

![Elevational Plane Contour Plots, Linear KZK Sim, 30 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/comparisons/focus30mm/kzk_30mm_elevational.png)

##### Lateral Planes
Contour plot slices at lateral positions of 0.00 cm, 0.06 cm, and 0.14 cm can be found below. These planes were chosen to be around 0.00 cm because both the Field II and KZK sims had maximum normalized intensities at 0.00 cm lateral position.### Contour Planes
The contour plane plots for the Field II and KZK sims can be found below in each of the three planes (elevational, lateral, and depth).

##### Elevational Planes
Contour plot slices at elevational positions of -0.14 cm, -0.06 cm, and 0.00 cm can be found below. These planes were chosen to be around 0.00 cm because both the Field II and KZK sims had maximum normalized intensities at 0.00 cm lateral position.

 * Field II - Elevational Plane Contour Plots

![Elevational Plane Contour Plots, Field II Sim, 70 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/comparisons/focus70mm/field2_70mm_elevational.png)

 * KZK - Elevational Plane Contour Plots

![Elevational Plane Contour Plots, Linear KZK Sim, 70 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/comparisons/focus70mm/kzk_70mm_elevational.png)

##### Lateral Planes
Contour plot slices at lateral positions of 0.00 cm, 0.06 cm, and 0.14 cm can be found below. These planes were chosen because KZK intensity field is maximum in 0.00 cm lateral position plane and Field II intensity field is max in 0.14 cm plane.

 * Field II - Lateral Plane Contour Plots

![Lateral Plane Contour Plots, Field II Sim, 70 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/comparisons/focus70mm/field2_70mm_lateral.png)

 * KZK - Lateral Plane Contour Plots

![Lateral Plane Contour Plots, Linear KZK Sim, 70 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/comparisons/focus70mm/kzk_70mm_lateral.png)

##### Depth Planes
Contour plot slices at depth positions of 3.75 cm, 5.10 cm, and 6.40 cm can be found below. These planes were chosen because the KZK sim had maximum normalized intensity at a depth of 6.40 cm, while the Field II sim had maximum normalized intensity at a depth of 3.75 cm.

 * Field II - Depth Plane Contour Plots

![Depth Plane Contour Plots, Field II Sim, 70 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/comparisons/focus70mm/field2_70mm_depth.png)

 * KZK - Depth Plane Contour Plots

![Depth Plane Contour Plots, Linear KZK Sim, 70 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/comparisons/focus70mm/kzk_70mm_depth.png)

