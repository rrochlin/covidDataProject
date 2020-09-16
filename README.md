# covidDataProject
This is my repository for the data visualization project that i am participating in run through the uw.

9/6/2020
There are currently 2 matlab files and a folder containing several .txt files of sensor data. In order to run the project you will want to clone this repository locally,
add the cloned files to your active MATLAB path. Then you can run the dataHandling.m script. This script creates several cell arrays we will use to create a
"budget animation". Once the program has ran successfully you can run surfScatter.m. This will open up a new figure and begin plotting the array in order of timestamp.

Currently the data is represented in a normal distribution from each sensor point, with limits of 5 units in the x & y direction, and 2.5 units in the z direction.

The unfilled black circles represent sensors and the filled circles represent droplets sized proportionally to eachother.

The color key for the scatter plot is(size,color,filled/unfilled): 

	Dp 0.3 ---	1,’Red’,’filled’
	Dp 0.5 ---	2,’Green’,’filled’
	Dp 1.0 ---	4,’Blue’,’filled’
	Dp 2.5 ---	10,’Yellow’,’filled’
	Dp 5.0 ---	20,’Magenta’,’filled’
	Dp 10.0 ---	40,’Cyan’,’filled’



9/10/2020
meshGridPrep.m is a work in progress right now, when finished it will produce a series of timeslices that have been smoothened using interp3 to represent the percieved particle densities at all points in the room. Hopefully this will be helpful for different modelling techniques than the current scatter method.

9/16/2020
Redesigned surfScatter and dataHandling, they are now callable functions. use help 'function name' to see a brief description and recommended default calls.
Notes on surfScatter : right changeing the time window requires going into the actual function code and changing the index values of bottom and top to be set where you want. Currently they are set to show the time from 12:20 - 12:35.
The interactions between the scatter points and the legend are handled by using a callback function to toggle the visibility of 7 hidden points. Then using linkprop() we link the visibility of these points to every corresponding plot generated. Seems to arbitrarily become broken as different instances of the code is changed. Pause(.05) was chosen as it appears to be the shortest pause while still retaining the ability to rotate the graph and use the hide points callback function.
This function by default ignores all 0 values and its runspeed is constrained by the computational speed that it can calculate and draw scatters, not by how long the time delay is.
