# phase_phase

These Matlab scripts provide the main n:m phase-locking analyses used in the Scheffer-Teixeira & Tort, eLife 2016.
They can be used to reproduce or further explore our results with the data we made available online at Dryad. 

Brief instructions:

1) Open the caller script.

2) Run the first cell and select the folder where this package is to be stored.

3) In the second cell you can choose which signal type you want to analyze.
The default signal is a white noise. If you want to use real LFP, uncomment the
line containing 'real_lfp'. 

4) Choose which surrogates you want to include. The default uses all analyses.
Just comment out those you are not interested.

5) Define the parameters of your analysis. Each parameter is described in the caller routine.

When using real signals, a window will open and ask for mat file. You can
choose more than one file, which can be sessions from the same animal, several sessions
from several animals, or just one session from one animal. The only requisite is that
the file must contain channels x time array *named LFP*. As a template, we refer to our data 
avaiable at Dryad.

To avoid memory out messages, the script opens and runs each file in sequential order.

After plotting the results, all analyses are stored in a variable called Data.

In addition to the toolbox files, we also provide separated .m files for simulating and analyzing Kuramoto oscillators; these files reproduce Figures 1 and 6 of our paper and are named accordingly.  

