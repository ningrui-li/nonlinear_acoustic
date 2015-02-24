How to Visualize Your Data in ParaView
======================================

### Intro

This is intended as a guide for setting up ParaView to properly visualize differences in intensity fields between KZK sims run with different nonlinear coefficients and attenuation coefficients. Assuming we would like to visualize N intensity fields simultaneously in Paraview, the end product should be N different linked camera views that each have a linked Clip filter. This means that moving the camera in one view will also move the camera in all other views in the same way. Changing the visualized intensity plane by changing a clipped plane in one view will change the clipped plane in all other views. This makes it easier to compare intensity fields as everything is linked. 

If the number of intensity fields gets large, I will consider writing a script that takes in N intensity fields .vts/.vtk files as an input and outputs a macro file that can be loaded in ParaView to automatically perform the steps below for setting up the data visualization scheme.

### Procedure

1. Open ParaView. I have a copy of the binary stored in `/luscinia/nl91/paraview/ParaView-4.2.0-Linux-64bit/bin/`. Go to that directory and type `./paraview &` to start it. You can also make an alias to do this so  you don't have to find that directory every time you want to start ParaView.

2. Go to top menu bar and select `File`, followed by `Open` to load in a .vts or .vtk dataset you would like to visualize. Once loaded, click the green `Apply` button on the left sidebar to get the model onto the scene. 

3. If you have only one intensity field, skip to step 5 to learn how to apply the Clip filter. If you want to load in more intensity fields in different camera views, read on.

4. In the top bar of your scene window, there are two split window buttons. One splits the current camera horizontally, the other splits it vertically. If you are having trouble locating these buttons, check [here](http://www.paraview.org/Wiki/Beginning_GUI#Split_windows) for pics. Press `Render View` and repeat step 2 to load in another intensity field. Link separate scenes by right-clicking on a camera view then pressing the only option available: `Link Camera...`. Then press the camera you want to link it to. It is best to link all cameras to a single "master" scene, then move around that "master" scene to manipulate the rest of the cameras.

5. For each scene, press the Clip filter button to create a filter button. Then press the green `Apply` button again to apply it. Remember to do this for all scenes.

6. Now we want to link the filters together. Open up the `Tools` menu on the top menu bar, and press `Manage Links...`. Hit `Add...` to add a new link relationship. In the `Add Link` box that pops up, you should see your Clip filters there. They're called `Clip1`, `Clip2`, etc. Assuming you have `Clip1` as your "master" Clip filter, press the "+" next to `Clip1` on the left side of the `Add Link` box and select `Plane` on the subtree that shows up. On the other side of the `Add Link` box, select another Clip filter, pressure the "+" next to it, and select `Plane` on the subtree that shows up. Press `Ok` when done. Repeat until all your Clip filters are linked to `Clip1`.

7. Close the `Link Manager` and go back to the main ParaView screen. Left click on the first camera view to select it. Now you can manipulate the camera and the other scenes will move in the same way. Click on `Clip1` in the left sidebar (called `Pipeline Browser`). Try adjusting the values, like origin or normal, of the Clip filter and re-applying it. All scenes should be clipped the same way. You are done!
