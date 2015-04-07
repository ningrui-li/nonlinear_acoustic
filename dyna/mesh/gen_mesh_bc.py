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
focalDepths = [7.0]
nodeSpacing = 0.025
elevCM = 0.6
latCM = 2.5
axialCM = 12.0

for fd in focalDepths:

    nodefile = 'nodesFoc%.fmm.dyn' % (fd*10)
    elemfile = 'elemsFoc%.fmm.dyn' % (fd*10)

    os.system('python %s/mesh/GenMesh.py '
              '--nodefile %s '
              '--elefile %s '
              '--xyz -%.1f 0.0 0.0 %.1f -%.1f 0.0 '
              '--numElem %i %i %i' %
              (FEMGIT, nodefile, elemfile,
               elevCM, latCM, axialCM,
               round(elevCM/nodeSpacing), round(latCM/nodeSpacing), round(axialCM/nodeSpacing)
               )
              )

    os.system('python %s/mesh/bc.py '
              '--pml '
              '--nodefile %s '
              '--elefile %s '
              '--bcfile bcPMLfoc%.fmm.dyn' %
              (FEMGIT, nodefile, elemfile, fd*10)
              )
