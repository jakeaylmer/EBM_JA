function [index, latitude] = IceEdgeIndex(phi, HI)
% ICEEDGEINDEX Find the index of the element corresponding to the ice edge
% location.
% 
%   ind, lat = ICEEDGEINDEX(HI) returns the smallest index (ind) of HI
%   corresponding to a value of HI which is strictly greater than zero and
%   the corresponding ice-edge latitude.
% -------------------------------------------------------------------------
        
    if HI(length(HI)) == 0
        index = length(HI)+1;
        latitude = phi(length(phi));
    else
        index = 1;
        while HI(index) <= 0
            index = index + 1;
        end
        latitude = phi(index);
    end
    
end
