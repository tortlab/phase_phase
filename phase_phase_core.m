function [output] = phase_phase_core(phase1,phase2,m)

        output = mean(exp(i*(m*(unwrap(phase1)) - unwrap(phase2))));
end
