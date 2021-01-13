Emanuele Caruso - 182882

Project 03 - Range only SLAM

launch the program with:

octave main.m

there is also a program for a "visual testing" of the validity of the initialization
for the initial guess, if desired launch it with:

octave test_initialization_of_landmarks_guess_on_groundtruth.m

results of the LS problem are plotted after launching main.m, but it wil also
save an animated gif in this directory (need to uncomment the line),
which shows the evolution of the state during the iteration of Gauss Newton.
