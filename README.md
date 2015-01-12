# Nonlinear Acoustic Propagation Pratt Fellows Project
Code for running and viewing results of Field II and KZK simulations.

KZK Simulation results can be found in `/luscinia/nl91/scratch/c52/`
There are KZK simulation results for focal depths of 30 mm and 70 mm. For each focal depth, there are intensity fields for three different initial pressure inputs: the original measured pressure inputs (`original`), the tilt corrected pressure inputs (`untilted`), and quarter symmetric pressure inputs based on the tilt corrected inputs (`quarter_symmetric`). Each of the three subfolders contains the KZK simulation script (`try3d_kzk_sim`), the binary output file from the KZK simulation (`P.dat`), and the MAT-file containing the intensity field generated from the binary output file.

The KZK intensity fields generated from the quarter symmetric inputs will be the ones compared with the intensity fields generated from the Field II simulations, as all intensities will then be quarter symmetric.

# Metrics
The `metrics` folder contains functions for creating various plots of each intensity field for convenient comparison between Field II and KZK simulation results.
