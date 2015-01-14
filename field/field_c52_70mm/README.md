# 70 mm Focus Sim

### Mesh generation

A mesh with quarter symmetry and the following dimensions was generated using `GenMesh.py` from the [FEM tools](https://github.com/Duke-Ultrasound/fem).

```
python GenMesh.py --xyz -1.2 0 0 2.0 -9.0 0 --numElem 60 100 180
```

- Elevational position ranged from -1.2 cm to 0.0 cm with 0.02 cm increments.
- Lateral position ranged from 0.0 cm to 2.0 cm with 0.02 cm increments.
- Depth position ranged from -9.0 cm to 0.0 cm with 0.05 cm increments.

**Note: `nodes.dyn` and `elems.dyn` are not included as part of this GitHub repo because of their large file size. You must run `GenMesh.py` in order to generate the nodes and elements files to successfully run the rest of the code. There should be 1,115,141 nodes and 1,080,000 elements.**

### Solving for intensity field

The intensity field was calculated by running `field2dyna.m` from the [FEM tools](https://github.com/Duke-Ultrasound/fem).

`field2dyna('nodes.dyn', 0.45, 3.5, [0 0 0.07], 2.36, 'c52', 'gaussian')`

The parameters used above are:

- alpha = 0.45 dB/cm/MHz (liver)
- F/# = 3.5 (using estimated aperture width of 2.0 cm, shown in plot made by `estimate_fnum_70mm.m`)
![F/# Estimation, C5-2, 70 mm Focus](https://raw.githubusercontent.com/Ningrui-Li/nonlinear_acoustic/master/field/field_c52_70mm/estimate_fnum_c52_70mm.png)
- focus = 0.07 m
- excitation frequency = 2.36 MHz
- transducer = c5-2

