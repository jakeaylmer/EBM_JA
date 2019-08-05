function [TML_new, HI_new] = FreezeAndMelt(TML_old, HI_old, Hml_old, p)
% FREEZEANDMELT 'Convert' melted sea-ice latent heat into ocean mixed-layer
% sensible heat content, and frozen mixed-layer into sea-ice latent heat.
%
%   [TML_new, HI_new] = FREEZEANDMELT(TML_old, HI_old, HML_old, p) returns
%   updated mixed-layer temperature and sea-ice thickness profiles after
%   transferring any negative ocean sensible heat content to sea-ice and
%   any positive sea-ice latent heat to the ocean. Hml_old is the mixed-
%   layer depth profile and p is the parameter struct.
% -------------------------------------------------------------------------
    
    TML_new = TML_old;
    HI_new = HI_old;
    z = p.Lf./(p.co*p.rhoo*Hml_old);
    
    for j = 1:length(TML_old)
        
        if HI_old(j) < 0
            
            HI_new(j) = 0;
            TML_new(j) = TML_old(j) - z(j)*HI_old(j);
            
            if TML_new(j) < p.Tf
                HI_new(j) = (p.Tf-TML_new(j))/z(j);
                TML_new(j) = p.Tf;
            end
            
        elseif HI_old(j) == 0 && TML_old(j) < p.Tf
            
            HI_new(j) = (p.Tf-TML_old(j))/z(j);
            TML_new(j) = p.Tf;
            
        elseif HI_old(j) > 0
            
            HI_new(j) = HI_old(j) + (p.Tf-TML_old(j))/z(j);
            TML_new(j) = p.Tf;
            
            if HI_new(j) < 0
                TML_new(j) = p.Tf -z(j)*HI_new(j);
                HI_new(j) = 0;
            end
            
        end
        
    end
    
end
