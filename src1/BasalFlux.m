function Fb = BasalFlux(phi, p)
% BASALFLUX Returns the deep ocean heat transport convergence at mesh
% point(s) phi [rad].
%
%   Fb = BASALFLUX(phi, p) returns the upward heat flux from the deep ocean
%   where phi may be a single mesh point or a vector of mesh points in
%   radians, and p is the struct of model parameters.
% -------------------------------------------------------------------------
    Fb = (cos(phi).^(2*p.N-2)).*(1-(2*p.N+1)*sin(phi).^2);
    Fb = -(p.psi/(2*pi*p.RE^2))*Fb;
    Fb = Fb + .75*p.Fbp*((1/3)-cos(2*phi));
end
