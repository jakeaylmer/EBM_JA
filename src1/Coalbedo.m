function A = Coalbedo(phi, phi_i, p)
% COALBEDO Gives the coalbedo a(phi) from a given ice-edge latitude.
%
%   a = COALBEDO(phi, phi_i, p) returns a vector containing the coalbedos
%   a at each coordinate in phi [rad], where the ice edge is located at
%   phi_i [rad] which is not necessarily an element of phi. p is the
%   struct of model parameters.
% -------------------------------------------------------------------------
    A = 0.5*(p.a0 - p.a2*phi.^2 + p.ai - ...
        (p.a0 - p.a2*phi.^2 - p.ai).*erf((phi-phi_i)/p.dphi));
    %A = 0.72 - 0.15*phi.^2;
end

