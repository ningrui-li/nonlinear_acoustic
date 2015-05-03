"""
gen_mesh_bc.py

Generate meshes and PML boundary conditions for QIBA digital phantoms.

Mark Palmeri
mlp6@duke.edu
2015-03-17
"""

import os

FEMGIT = '/home/mlp6/git/fem'

# all units are CGS
# focalDepths, latCM, and axialCM are parallel arrays.
# Each index corresponds to a set of lateral and axial extents for a specific focal depth.
focalDepths = [3.0 7.0]
latEleNodeSpacing = 0.020
depthNodeSpacing = 0.025
elevCM = 0.6
latCM = [1.2 2.0]
axialCM = [5.2 9.0]

for i in range(0, len(focalDepths)):

    nodefile = 'nodesFoc%.fmm.dyn' % (fd[i]*10)
    elemfile = 'elemsFoc%.fmm.dyn' % (fd[i]*10)

    os.system('python %s/mesh/GenMesh.py '
              '--nodefile %s '
              '--elefile %s '
              '--xyz -%.1f 0.0 0.0 %.1f -%.1f 0.0 '
              '--numElem %i %i %i' %
              (FEMGIT, nodefile, elemfile,
               elevCM, latCM[i], axialCM[i],
               round(elevCM/latEleNodeSpacing), round(latCM[i]/latEleNodeSpacing), round(axialCM[i]/depthNodeSpacing)
               )
              )

    os.system('python %s/mesh/bc.py '
              '--pml '
              '--nodefile %s '
              '--elefile %s '
              '--bcfile bcPMLfoc%.fmm.dyn' %
              (FEMGIT, nodefile, elemfile, fd*10)
              )
