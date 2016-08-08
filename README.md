# phase_phase

These Matlab scripts package provides the main analyses used in the Scheffer - Teixeira & Tort eLife paper (2016).
It can be used as a fast way to reproduce or further explore our results with our online avaiable data (and the caller.m script). 
Also, it can be used and adapted as a toolbox for phase - phase coupling.

Brief instructions

1) Open the caller script 

2) Run the first cell and select the folder where this package are stored.

3) In the second cell you can choose which signal type you want to analyze.
The default signal is a white noise. If you want to use real LFP, uncomment the
line containing 'real_lfp'. 

4) Choose which surrogates you want to include. The default uses all analyses.
Just comment out those you are not interested.

5) Lastly, define some parameters. Each parameter is described in the caller routine.

We notice that while using real signals, a window will open and ask for data. You can
choose more than one file, which can be sessions from the same animal, several sessions
from several animals, or just one session from one animal. The only requisite is that
the file must contain a nxm (channels vs time) matrix variable named LFP. You can
refer to our avaiable data as a template.

To avoid memory out messages, the script open and run each file in sequential order.

After plotting the results, all performed analyses are also stored in a variable called Data.

