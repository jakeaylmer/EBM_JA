function TS = SurfaceTemp(TA, TML, HI, S, phi, p)
% SURFACETEMP Find the surface temperature profile from a given atmosphere
% and ocean mixed-layer temperature profiles and sea-ice thickness profile
% at a specified time t.
%
%   TS = SURFACETEMP(TA, TML, HI, t, x, p) returns the surface temperature
%   at assuming atmosphere temperature profile TA, mixed-layer temperature
%   profile TML, sea-ice thickness profile HI, corresponding mesh x and
%   time t. p is the struct of model parameters.
% -------------------------------------------------------------------------

   TS = TML;
   
   if any(HI) > 0 % sea ice exists somewhere
       
       [phii_j, phii] = IceEdgeIndex(phi, HI);
       
       aS = Coalbedo(phi, phii, p).*S;
       Td = (p.ki*p.Tf + HI.*(aS - p.Aup + p.Adn + p.Bdn*TA))./(...
           p.ki + p.Bup*HI);
       
       for j = phii_j:length(phi)
           TS(j) = p.Tm*(Td(j)>p.Tm) + Td(j)*(Td(j)<=p.Tm);
       end
       
   end 

end

