function [] = SaveData(t, TA, TML, TS, HI, params, subdir, filename)
% SAVEDATA Save data arrays to file 'filename' in data\subdir.
% -------------------------------------------------------------------------
    
    if endsWith(filename, '.mat')
        filename = filename(1:length(filename)-4);
    end
    
    sd_path = ['..' filesep 'data' filesep subdir];
    if exist(sd_path, 'dir')
        fprintf('Now saving to: %s.mat\n', [sd_path filesep filename]);
    else
        fprintf('Making directory: %s', sd_path);
        mkdir(sd_path);
        fprintf('\nNow saving as: %s.mat\n', filename);
    end
    
    save([sd_path filesep filename], 't', 'TA', 'TML', 'TS', 'HI');
    save([sd_path filesep filename '_params'], '-struct', 'params');
    
end
