# Nonlinear Acoustic Propagation Pratt Fellows Project
Code for running and viewing results of Field II and KZK simulations.

Results of the KZK simulation that were run using experimentally measured face pressures can be found in `/luscinia/nl91/scratch/`.
There are KZK simulation results for focal depths of 30 mm and 70 mm. For each focal depth, there are intensity fields for three different initial pressure inputs: the original measured pressure inputs (`original`), the tilt corrected pressure inputs (`untilted`), and quarter symmetric pressure inputs based on the tilt corrected inputs (`quarter_symmetric`). Each of the three subfolders contains the KZK simulation script (`try3d_kzk_sim`), the binary output file from the KZK simulation (`P.dat`), and the MAT-file containing the intensity field generated from the binary output file.

The KZK intensity fields generated from the quarter symmetric inputs will be the ones compared with the intensity fields generated from the Field II simulations, as all intensities will then be quarter symmetric.

## Experimentally Measured Face Pressure Field Processing
The `face_pressure` folder contains code used to process the experimentally measured input pressure fields before using them as inputs to the KZK simulation.

## KZK Simulations
The `kzk` folder contains code used to synthesize Field II face pressure inputs for the KZK sim as well as scripts used to run the KZK sims.

## Field II Comparison Simulation
The `field` folder contains the code used to run the Field II simulations for comparison to the KZK simulations that were run in linear mode (β = 0).

## Metrics
The `metrics` folder contains MATLAB functions for creating various plots of each intensity field that allow comparison between Field II and/or KZK simulation results.

## Comparisons
The `comparisons` folder contains the scripts used to load and compare the intensity data for the Field II and KZK sims. Differences in intensity fields generated from running the KZK sim using different attenuation and nonlinearity parameters are also evaluated. The functions from `metrics` will be used to compare these intensity fields.

## Presentations
The `presentations` folder contains various posters and slides made using these simulation results.

ningrui.li@duke.edu
