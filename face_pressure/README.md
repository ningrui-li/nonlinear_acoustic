Experimentally Measured Pressure Input Processing
=================================================
### Processing Scripts
 * `focus30mm` contains the steps and scripts used to process the 30 mm focal depth pressure inputs from the C5-2.
 * `focus70mm` contains the steps and scripts used to process the 70 mm focal depth pressure inputs from the C5-2.

### Processing Functions
 * `createQuarterSymmetry.m` is a MATLAB function that was used in the pressure processing scripts to create perfectly quarter symmetric data by averaging the four corresponding values in each pressure plane quadrant. The pressure values in all four analogous locations were then set to this mean. The pressure along the center axes locations (lateral pos = 0 mm or elevational pos = 0 mm) were not part of any quadrant, so they formed a small discontinuity in pressure values between each quadrant. To fix this, pressure values on the center axes were interpolated by setting them equal to the average of the two adjacent pressure values for each on-axis position. The center point of each plane (at lateral position 0 mm and elevational position 0 mm) was interpolated by averaging using the four diagonally adjacent points, one from each quadrant.
