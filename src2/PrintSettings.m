function PrintSettings(settings)
% PRINTMYSETTINGS Display the settings being used as an echo to the command
% line.
% -------------------------------------------------------------------------
    
    fprintf('\nUsing %d mesh points on phi = [0, pi/2] inclusive', ...
        settings.nphi);
    
    fprintf('\nModel time step: dt = %.2f days', 365/settings.nt);
    
    fprintf('\nIntegrating for %d time steps in total (%.0f years)', ...
        settings.nt*settings.t_total-1, settings.t_total);
    
    fprintf('\nSaving data every %d time steps (%.2f days)', ...
        settings.ns, 365*settings.ns/settings.nt);
    
end
