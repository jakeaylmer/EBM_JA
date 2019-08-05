function [TA_0, TML_0, TS_0, HI_0] = InitialConditions(phi, p, s)
% INITIALCONDITIONS Calculate a set of initial profiles of atmospheric,
% surface and mixed layer temperatures and sea-ice thickness profiles which
% also satisfy boundary conditions.
%
%   [TA_0, TML_0, TS_0, HI_0] = INITIALCONDITIONS(phi, p, s) returns arrays
%   of length equal to that of phi, the coordinates in radians,
%   corresponding to initial conditions for temperature profiles and ice
%   thickness. p is the struct of model parameters and s is the struct of
%   model settings.
% -------------------------------------------------------------------------
    
    fprintf('\nGenerating initial conditions');
    
    TA_0 = .5*((p.TA_eq+p.TA_pole) + (p.TA_eq-p.TA_pole)*cos(2*phi));
    
    TML_0 = .5*((p.TML_eq+p.Tf) + (p.TML_eq-p.Tf)*cos(180*phi/p.phii_deg_init));
    
    B = p.HI_pole/((pi/2)-p.phii_deg_init*(pi/180));
    A = -B*p.phii_deg_init*(pi/180);
    HI_0 = A + B*phi;
    
    HI_0 = HI_0.*(HI_0>0);
    TML_0 = TML_0.*(HI_0<=0) + p.Tf*(HI_0>0);
    
    [~, S] = Insolation(s);
    
    TS_0 = SurfaceTemp(TA_0, TML_0, HI_0, S(1,:), phi, p);
    
end
