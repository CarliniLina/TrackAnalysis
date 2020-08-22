This script computes angles between successive steps in multiple trajectories and extracts distributions of step sizes.

Requires a matlab cell with all tracks of interest (pre-filtered) in workspace.

Explanation/example use of output of interest (thetaCat):

thetaCat is a cell, where each cell contains all the angles for a given time delay. 
For example: thetaCat{1} is a matrix which contains all the angles
 between 0 and 180 deg for the shortest time delay. If your data was acquired
 with a (for ex) 10 ms delay between frames, then thetaCat{1} contains all the
 angles at 10 ms, thetaCat{2} contains all the delays at 20 ms, etc. So to plot a directional distribution at time delay i: histogram(thetaCat{i}).