"""
nonlinear.py - setup SGE scripts to launch dyna sims on the cluster
"""

import os
from math import sqrt as sqrt

YoungsModuli = [3.0]  # kPa
ExcitationDurations = [300]  # us
#FocalDepths = [30 70]  # mm
FocalDepths = [30]
Fnums = [3.5]
Beta = [0.0, 3.5, 7.0]
#alpha = [0.005, 0.3, 0.45, 1.0, 1.5]
alpha = [0.005] 
root = '/pisgah/nl91/scratch'
loadsRoot = '/luscinia/nl91/nonlinear_acoustic/dyna/loads/focus30mm'

femgit = '/home/mlp6/git/fem'
indyn = 'nonlinear_pml.dyn'
sgeFile = 'nonlinear_pml.sh'

for YM in YoungsModuli:
    for FD in FocalDepths:
        for B in Beta:
	    for a in alpha:
                for ED in ExcitationDurations:
                    for FN in Fnums:
                        sim_path = '%s/data/E%.1fkPa/foc%imm/B_%.1f/a_%.3f/F%.1f/EXCDUR_%ius/' % \
                               (root, YM, FD, B, a, FN, ED)

                        if not os.path.exists(sim_path):
                            os.makedirs(sim_path)
			    os.makedirs(sim_path + 'sgetmp/')

                        os.chdir(sim_path)
                        print(os.getcwd())

                        if not os.path.exists('res_sim.mat'):
                            print('\tres_sim.mat missing . . . running ls-dyna')
                            os.system('cp %s/dyna/%s .' % (root, indyn))
                            os.system("sed -i -e 's/YM/%.1f/' %s" %
                                      (YM * 10000.0, indyn)
                                      )
                            os.system("sed -i -e 's/TOFF1/%.1f/' %s" %
                                      (ED, indyn)
                                      )
                            os.system("sed -i -e 's/TOFF2/%.1f/' %s" %
                                      (ED + 1, indyn)
                                      )
                            os.system("sed -i -e 's/TRUN/%i/' %s" %
                                      (25 / sqrt(YM/3), indyn)
                                      )
                            os.system("cp %s/B_%.1f/a_%.3f/PointLoads-f2.36-"
                                      "F%.1f-FD0.0%i-a%.2f.dyn loads.dyn" %
                                      (loadsRoot, B, a, FN, FD, a)
                                      )
                            os.system("cp %s/mesh/nodesFoc%imm.dyn nodes.dyn" %
                                      (root, FD)
                                      )
                            os.system("cp %s/mesh/elemsFoc%imm_pml.dyn "
                                      "elems_pml.dyn" % (root, FD)
                                      )
                            os.system("cp %s/mesh/bcPMLfoc%imm.dyn bc_pml.dyn" %
                                      (root, FD)
                                      )
                            os.system('cp %s/dyna/%s .' % (root, sgeFile))

                            os.system('qsub %s' % (sgeFile))
                        else:
                            print('res_sim.mat already exists')
