function [t_sol, sol] = Insolation(settings)
% INSOLATION Obtain the insolation data and its time grid.
% 
% Solar radiation data is assumed to be in W/m^2 and be on the correct
% spatial grid. The time grid must also match that used by the model, and
% the first row of data should contain the insolation as a function of
% latitude at t = 0 yr, which is defined to be 0000hr on Jan-01. Subsequent
% data should be every dt years apart (as specified in settings). The final
% entry should be that for t < 1 (note: strictly less than 1: t = 0 and
% t = 1 are equivalent). Store solar radiation data in the 'solar'
% sub-directory.
% -------------------------------------------------------------------------
    
    % Add extension to file name (needed for existence checking):
    if not(endsWith(settings.Sdata_file, '.mat'))
        settings.Sdata_file = [settings.Sdata_file '.mat'];
    end
    
    data_file_path = ['..' filesep 'solar' filesep settings.Sdata_file];
    
    if not(exist(data_file_path, 'file') == 2)
        % If not found there we may be in a different starting directory,
        % so look further up directory tree for solar, if not raise error:
        data_file_path = ['..' filesep data_file_path];
        if not(exist(data_file_path, 'file') == 2)
            error(['Solar radiation data not found: ' settings.Sdata_file]);
        end
    end
    
    Sdat = load(data_file_path);
    Sdat_fields = fieldnames(Sdat);
    sol = Sdat.(Sdat_fields{1});
    
    dt = 1/settings.nt;
    t_sol = 0 : dt : (1-dt);
    
    if length(sol(:,1)) ~= length(t_sol)
        error('Solar radiation data not aligned to specified time grid');
    end
    
end
