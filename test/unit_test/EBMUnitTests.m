function results = EBMUnitTests()
% UNITTESTS Run all unit tests.
% -------------------------------------------------------------------------

    suite = {'test_SurfaceTemp', ...
             'test_IceEdgeIndex', ...
             'test_FreezeAndMelt', ...
             'test_Interpolate'};
    
    results = runtests(suite);

end