function Hml = MixedLayerDepth(phi, p)
% MIXEDLAYERDEPTH Returns the ocean mixed-layer depth at mesh point(s) phi.
% -------------------------------------------------------------------------
    Hml = p.Hml_const*ones(size(phi));
end
