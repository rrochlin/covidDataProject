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
