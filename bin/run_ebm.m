function run_ebm(filename, subdir, usesaved)
% RUN_EBM Main program for the Aylmer et al. (2019) EBM numerical model.
%     
%     RUN_EBM('my_file_name') runs the numerical model once with the
%     settings specified in settings() and parameters(), saving the data
%     with filename 'my_file_name'.
%
%     RUN_EBM('my_file_name', 'my_subdir_name') does the same but saves
%     into the sub-directory 'my_subdir_name' in the 'data' directory.
%     
%     If a sub-directory name is not provided, one is created with a date
%     stamp (at time of saving) as its name. If a filename is also not
%     provided, the filename is given as a date and time stamp (at the time
%     of saving.
%
%     RUN_EBM('my_file_name', 'my_subdir_name', 1) does the same but also
%     uses saved initial conditions from file as specified in SETTINGS.
% -------------------------------------------------------------------------
    
    % --- Default input arguments --- %
    if nargin < 3
        usesaved = 0;
    end
    if nargin == 1
        subdir = ['data_' datestr(now, 'yyyy-mm-dd')];
    elseif nargin == 0
        filename = ['data_' datestr(now, 'yyyy-mm-dd_HHMM') 'hr'];
        subdir = ['data_' datestr(now, 'yyyy-mm-dd')];
    end
    
    % --- Add all model code directories to system PATH --- %
    addpath('..');
    addpath(['..' filesep 'bin']);
    addpath(['..' filesep 'src1']);
    addpath(['..' filesep 'src2']);
    
    % --- Get settings and physical parameters --- %
    sets = settings();
    params = parameters();
    phi = linspace(0, pi/2, sets.nphi);  % latitude coordinates in RADIANS
    
    % --- Set up initial conditions --- %
    if usesaved == 1  % use from a file
        [TA0, TML0, TS0, HI0] = LoadInitialConditions(sets.ic_file, ...
            sets.ic_subdir);
        if not(length(TA0) == sets.nphi)  % interpolate onto different grid
            fprintf('\nRe-gridding from %d to %d grid points\n', ...
                length(TA0), sets.nphi);
            TA0 = interp1(linspace(0,pi/2,length(TA0)), TA0, phi);
            TML0 = interp1(linspace(0,pi/2,length(TML0)), TML0, phi);
            TS0 = interp1(linspace(0,pi/2,length(TS0)), TS0, phi);
            HI0 = interp1(linspace(0,pi/2,length(HI0)), HI0, phi);
        end
    else  % generate arbitrary initial conditions
        [TA0, TML0, TS0, HI0] = InitialConditions(phi, params, sets);
    end
    inits = [TA0; TML0; TS0; HI0];
    
    PrintSettings(sets);
    [t, TA, TML, TS, HI] = EBMSolver(phi, inits, sets, params);
    SaveData(t, TA, TML, TS, HI, params, subdir, filename);
    fprintf('\n')
    
end
