function s = settings()
% SETTINGS Declare the grid, time-stepping and data input/output settings
% and store them in a struct s which is returned.
% -------------------------------------------------------------------------
    
    % Number of mesh points between 0 deg and 90 deg (inclusive). If dphi
    % is the desired grid resolution, nphi = 1 + (90 / dphi):
    s.nphi = 361;
    
    % Timing parameters. t = 0, 1, 2, ... is 0000hr on 01-Jan:
    s.nt = 2*365;  % no. of time steps per year [int] (-> dt = (365/nt) days)
    s.t_total = 15;  % total integration time in whole number of years [int]
    s.ns = 10;  % no. of time steps between saved data [int].
                % NB. nt/ns must be an integer
    
    % File name and sub-directory name for initial conditions:
    s.ic_file ='';
    s.ic_subdir = '';
    
    s.Sdata_file = 'Sdata_qtrdeg_halfday';  % file name for insolation data
    
    s.PDEPE_OPT = odeset('RelTol',1e-7);  % PDE-solver parameters

end
