function [t_save, TA_SAVE, TML_SAVE, TS_SAVE, HI_SAVE] = EBMSolver(phi, ...
    initial_conditions, s, p)
% EBMSOLVER ...
% -----------------------------------------------------------------------------
    
    tstart = tic; % start timer
    
    % --- Extract initial conditions into separate arrays --- %
    TA_OLD = initial_conditions(1,:);
    TML_OLD = initial_conditions(2,:);
    TS_OLD = initial_conditions(3,:);
    HI_OLD = initial_conditions(4,:);
    
    % --- Time arrays (t is in years) --- %
    dt = 1/s.nt;
    t_master = linspace(0, s.t_total-dt, s.nt*s.t_total);
    t_save = t_master(1 : s.ns : length(t_master) );
    
    % --- Pre-allocate output (save) arrays --- %
    TA_SAVE = zeros(length(t_save), length(phi));
    TML_SAVE = zeros(length(t_save), length(phi));
    TS_SAVE = zeros(length(t_save), length(phi));
    HI_SAVE = zeros(length(t_save), length(phi));
    
    % --- First data sets are the initial conditions --- %
    TA_SAVE(1,:) = TA_OLD;
    TML_SAVE(1,:) = TML_OLD;
    TS_SAVE(1,:) = TS_OLD;
    HI_SAVE(1,:) = HI_OLD;
    rs = 2;  % save array index
    
    % --- Get the insolation data --- %
    [t_solar, S] = Insolation(s);
    
    % --- Constants used throughout --- %
    Ca = p.Ca*ones(size(phi));  % atmosphere column heat capacity
    Da = Ca*p.Ka/p.RE^2;  % atmosphere diffusion constant
    Fw = p.Fw;  % global warming (at top of atmosphere)
    
    fprintf('\nCarrying out time integration (%d calculations)', ...
        length(t_master)-1);
    fprintf('\nCounter: ');
    
    % --- Begin numerical integration --- %
    for r = 1:(length(t_master)-1)
        
        if r>1
            for rr=0:log10(r-1)
                fprintf('\b');
            end
        end
        fprintf('%d', r);
        
        % --- Ice edge array index and latitude --- %
        [~, phii] = IceEdgeIndex(phi, HI_OLD);
        
        t_s_j_old = 1 + mod(r-1, length(t_solar));
        t_s_j_new = 1 + mod(r, length(t_solar));
        
        % --- RHS vertical fluxes --- %
        Folr = p.Aolr + p.Bolr*TA_OLD;
        Fup = p.Aup + p.Bup*TS_OLD;
        Fdn = p.Adn + p.Bdn*TA_OLD;
        Fsol = Coalbedo(phi, phii, p).*S(t_s_j_old, :);
        Fb = BasalFlux(phi, p);
        Hml = MixedLayerDepth(phi, p);
        
        Co = p.co*p.rhoo*Hml;
        Do = Co*p.Ko/p.RE^2;
        
        ATM_RHS = Fup - Fdn - Folr + Fw;
        OCN_RHS = (Fsol - Fup + Fdn + Fb).*(HI_OLD<=0);
        ICE_RHS = (Fsol - Fup + Fdn + Fb).*(HI_OLD>0);
        
        TA_NEW = IntegrateT(phi, t_master(r), dt, TA_OLD, ATM_RHS, ...
            Da, Ca, s.PDEPE_OPT);
        TML_NEW = IntegrateT(phi, t_master(r), dt, TML_OLD, OCN_RHS, ...
            Do, Co, s.PDEPE_OPT);
        HI_NEW = IntegrateH(dt, HI_OLD, ICE_RHS, p);
        
        [TML_NEW, HI_NEW] = FreezeAndMelt(TML_NEW, HI_NEW, Hml, p);
        TS_NEW = SurfaceTemp(TA_NEW, TML_NEW, HI_NEW, S(t_s_j_new,:), ...
            phi, p);
        
        % --- Copy data to save arrays --- %
        if rs <= length(t_save) && t_master(r+1) == t_save(rs)
            TA_SAVE(rs, :) = TA_NEW;
            TML_SAVE(rs, :) = TML_NEW;
            TS_SAVE(rs, :) = TS_NEW;
            HI_SAVE(rs, :) = HI_NEW;
            rs = rs+1;
        end
        
        % --- Reset OLD arrays for next time step --- %
        TA_OLD = TA_NEW;
        TML_OLD = TML_NEW; 
        TS_OLD = TS_NEW;
        HI_OLD = HI_NEW;
        
    end
    
    telapsed = datestr(seconds(toc(tstart)), 'HH:MM:SS');  % stop timer
    fprintf(['\nFinished in ' telapsed '\n\n']);

end

function T_new = IntegrateT(mesh, t, dt, T_old, RHS, D, C, PDEPE_OPT)
% Sub-function for integrating either the atmosphere or ocean mixed-layer
% temperature equations.
    
    soln = pdepe(0, @T_pde, @ic, @bc, mesh, ...
        linspace(t, t+dt, 3), PDEPE_OPT);
    T_new = soln(3,:);
    
    function [c, f, s] = T_pde(phi, ~, ~, dTdphi)
        c = Interpolate(mesh, C, phi)*cos(phi);
        f = Interpolate(mesh, D, phi)*cos(phi)*dTdphi;  % D = C*K/RE^2
        s = cos(phi)*Interpolate(mesh, RHS, phi);
    end
    
    function T0 = ic(phi)
        T0 = Interpolate(mesh, T_old, phi);
    end
    
    function [pl, ql, pr, qr] = bc(~, ~, ~, ~, ~)
        pl = 0; ql = 1; pr = 0; qr = 1;
    end
    
end

function H_new = IntegrateH(dt, H_old, RHS, p)
% Sub-function for integrating the ice-thickness equation.
    H_new = H_old - dt*RHS/p.Lf;
end
