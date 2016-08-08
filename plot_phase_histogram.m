function plot_phase_histogram(Data,ch,ses)
phasebin = Data.results.session(ses).channel(ch).PhaseBin;
Phases = Data.results.session(ses).channel(ch).PhaseCounts;

myfilter = fspecial('gaussian',[10 10], 20);
myfilteredimage = imfilter(Phases', myfilter, 'replicate');
imagesc(phasebin,phasebin,myfilteredimage)
axis xy square
colorbar
set(gcf,'color','w')
xlabel('Slower Oscillation Phases')
ylabel('Faster Oscillation Phases')
title('Phase Counts')

end