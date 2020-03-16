function [Ta0, Tml0, Ts0, Hi0] = ManualTestInitialConditions()
% MANUAL_TEST_INITIAL_CONDITIONS Check that the initial conditions function
% generates initial profiles consistent with the specified parameters.
%
% --Args--
% None. Uses current parameters and settings in parameters.m and settings.m
% respectively.
% 
% -------------------------------------------------------------------------
    
    addpath(['..' filesep '..']);
    addpath(['..' filesep '..' filesep 'bin']);
    addpath(['..' filesep '..' filesep 'src1']);
    addpath(['..' filesep '..' filesep 'src2']);
    
    s = settings();
    p = parameters();
    
    phi = linspace(0, 90, s.nphi);
    phi_rad = phi*pi/180;
    
    [Ta0, Tml0, Ts0, Hi0] = InitialConditions(phi_rad, p, s);
    
    figure; hold on;
    
    subplot(1,2,1); hold on;
    plot(phi, Ta0);
    plot(phi, Tml0);
    plot(phi, Ts0);
    legend({'T_a','T_{ml}','T_s'}, 'Location','northeast')
    title('Initial conditions (manual test)')
    xlabel(['Latitude (' char(176) 'N)']);
    ylabel(['Temperature (' char(176) 'C)']);
    grid;
    
    subplot(1,2,2); hold on;
    plot(phi, Hi0);
    xlabel(['Latitude (' char(176) 'N)']);
    ylabel('Ice thickness (m)');
    grid;

end
