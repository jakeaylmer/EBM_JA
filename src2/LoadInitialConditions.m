function [TA_0, TML_0, TS_0, HI_0] = LoadInitialConditions(filename, ...
    subdirname)
% LOADINITIALCONDITIONS Load initial conditions from a file. Returns
% vectors corresponding to the TA, TML, TS and HI profiles from the latest
% time step in the given data file.
% -------------------------------------------------------------------------
    
    if not(endsWith(filename, '.mat'))
        filename = [filename '.mat'];
    end
    
    fprintf('\nLoading initial conditions: %s', [subdirname filesep ...
        filename]);
    
    data = load(['..' filesep 'data' filesep subdirname filesep ...
        filename]);
    
    TA_0 = data.TA;
    TML_0 = data.TML;
    TS_0 = data.TS;
    HI_0 = data.HI;
    
    % If file contains data at multiple times (usually it does), extract
    % the last entry (largest t) only:
    if size(TA_0, 1) > 1
        TA_0 = TA_0(length(TA_0(:,1)), :); end
    if size(TML_0, 1) > 1
        TML_0 = TML_0(length(TML_0(:,1)), :); end
    if size(TS_0, 1) > 1
        TS_0 = TS_0(length(TS_0(:,1)), :); end
    if size(HI_0, 1) > 1
        HI_0 = HI_0(length(HI_0(:,1)), :); end
    
end
