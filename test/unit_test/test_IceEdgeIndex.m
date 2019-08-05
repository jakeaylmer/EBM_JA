function tests = test_IceEdgeIndex
% TEST_ICEEDGEINDEX Carry out unit tests for the ICEEDGEINDEX function.
    tests = functiontests(localfunctions);
end

%----------------------------------------------------------------------

function test_IceFree(testCase)
    phi = [0 0.25 0.5 0.75 1]*pi/2;
    hi = [0 0 0 0 0];
    expt = length(hi) + 1; [actl, ~] = IceEdgeIndex(phi, hi);
    verifyEqual(testCase, actl, expt, 'AbsTol',1e-12);
end

function test_IceFreeNegativeH(testCase)
    phi = [0 0.25 0.5 0.75 1]*pi/2;
    hi = [-1 -0.5 -0.25 -0.1 0];
    expt = length(hi) + 1; [actl, ~] = IceEdgeIndex(phi, hi);
    verifyEqual(testCase, actl, expt, 'AbsTol',1e-12);
end

function test_NearIceFree(testCase)
    phi = [0 0.25 0.5 0.75 1]*pi/2;
    hi = [0 0 0 0 0.1];
    expt = 5; [actl, ~] = IceEdgeIndex(phi, hi);
    verifyEqual(testCase, actl, expt, 'AbsTol',1e-12);
end

function test_Snowball(testCase)
    phi = [0 0.25 0.5 0.75 1]*pi/2;
    hi = [0.01 0.1 1 2 3];
    expt = 1; [actl, ~] = IceEdgeIndex(phi, hi);
    verifyEqual(testCase, actl, expt, 'AbsTol',1e-12);
end

function test_NearSnowball(testCase)
    phi = [0 0.25 0.5 0.75 1]*pi/2;
    hi = [0 0.01 0.1 0.4 1];
    expt = 2; [actl, ~] = IceEdgeIndex(phi, hi);
    verifyEqual(testCase, actl, expt, 'AbsTol',1e-12);
end

function setupOnce(~)  % do not change function name
    addpath(['..' filesep '..' filesep 'bin']);
    addpath(['..' filesep '..' filesep 'src1']);
    addpath(['..' filesep '..' filesep 'src2']);
end
