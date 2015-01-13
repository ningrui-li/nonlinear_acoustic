# 30 mm Focus Sim

### Mesh generation

A mesh with quarter symmetry and the following dimensions was generated using `GenMesh.py` from the [FEM tools](https://github.com/Duke-Ultrasound/fem).

```
python GenMesh.py --xyz -1.0 0 0 1.2 -5.2 0 --numElem 50 60 104
```

- Elevational position ranged from -1.0 cm to 0.0 cm with 0.02 cm increments.
- Lateral position ranged from 0.0 cm to 1.2 cm with 0.02 cm increments.
- Depth position ranged from -5.2 cm to 0.0 cm with 0.05 cm increments.

**Note: `nodes.dyn` and `elems.dyn` are not included as part of this GitHub repo because of their large file size. You must run `GenMesh.py` in order to generate the nodes and elements files to successfully run the rest of the code. There should be 326,655 nodes and 312,000 elements.**

### Solving for intensity field

The intensity field was calculated by running `field2dyna.m` from the [FEM tools](https://github.com/Duke-Ultrasound/fem).

`field2dyna('nodes.dyn', 0.45, 2.6, [0 0 0.03], 2.36, 'c52', 'gaussian')`

- alpha = 0.45 dB/cm/MHz (liver)
- F/# = 2.8 (using estimated aperture width shown in image below)
- focus = 0.03 m
- excitation frequency = 2.36 MHz
- transducer = c5-2

