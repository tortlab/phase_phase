function [output] = phase_phase_core(phase1,phase2,m)

        output = mean(exp(i*(m*(phase1) - (phase2))));
end