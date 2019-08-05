function tests = test_SurfaceTemp()
% TEST_SURFACETEMP Carry out unit tests for the SURFACETEMP function.
    tests = functiontests(localfunctions);
end

%----------------------------------------------------------------------

function test_IceFree(testCase)
    p = parameters();
    phi = [0 0.25 0.5 0.75 1]*pi/2;
    s = [5 10 20 40 70];
    ta = [10 8 5 3 0]; tml = [12 9 7 6 3]; hi = [0 0 0 0 0];
    ts = SurfaceTemp(ta, tml, hi, s, phi, p);
    verifyEqual(testCase, ts, tml, 'AbsTol',1e-12);
end

function setupOnce(~)  % do not change function name
    addpath(['..' filesep '..' filesep 'bin']);
    addpath(['..' filesep '..' filesep 'src1']);
    addpath(['..' filesep '..' filesep 'src2']);
end
