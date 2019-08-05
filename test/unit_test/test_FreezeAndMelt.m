function tests = test_FreezeAndMelt
% TEST_FREEZEANDMELT Carry out unit tests for the FREEZEANDMELT function.
    tests = functiontests(localfunctions);
end

%----------------------------------------------------------------------

function test_NoChange(testCase)
    p = parameters();
    hi  = [0 0 1];
    tml = [2 1 0] + p.Tf;
    hml = p.Hml_const*ones(size(tml));
    [act_tml, act_hi] = FreezeAndMelt(tml, hi, hml, p);
    verifyEqual(testCase, act_tml, tml, 'AbsTol',1e-12);
    verifyEqual(testCase, act_hi, hi, 'AbsTol',1e-12);
end

function test_FormIce(testCase)
    p = parameters();
    hi  = [0  0];
    tml = [1 -1] + p.Tf;
    hml = p.Hml_const*ones(size(tml));
    z = p.Lf./(p.co*p.rhoo*hml);
    [act_tml, act_hi] = FreezeAndMelt(tml, hi, hml, p);
    verifyEqual(testCase, act_tml, [1 0]+p.Tf, 'AbsTol',1e-12);
    verifyEqual(testCase, act_hi, [0 (1/z(2))], 'AbsTol',1e-12);
end

function test_FormOcean(testCase)
    p = parameters();
    hi  = [-1 0];
    tml = [0  0] + p.Tf;
    hml = p.Hml_const*ones(size(tml));
    z = p.Lf./(p.co*p.rhoo*hml);
    [act_tml, act_hi] = FreezeAndMelt(tml, hi, hml, p);
    verifyEqual(testCase, act_tml, [z(1) 0]+p.Tf, 'AbsTol',1e-12);
    verifyEqual(testCase, act_hi, [0 0], 'AbsTol',1e-12);
end

function test_FormIce_ConservesEnergy(testCase)
    p = parameters();
    hi  = [0  0];
    tml = [1 -1] + p.Tf;
    hml = p.Hml_const*ones(size(tml));
    [act_tml, act_hi] = FreezeAndMelt(tml, hi, hml, p);
    E_before = -p.Lf*sum(hi) + p.co*p.rhoo*sum(hml.*tml);
    E_after = -p.Lf*sum(act_hi) + p.co*p.rhoo*sum(hml.*act_tml);
    verifyEqual(testCase, E_after, E_before, 'AbsTol',1e-12);
end

function test_FormOcean_ConservesEnergy(testCase)
    p = parameters();
    hi  = [-1 0];
    tml = [0  0] + p.Tf;
    hml = p.Hml_const*ones(size(tml));
    [act_tml, act_hi] = FreezeAndMelt(tml, hi, hml, p);
    E_before = -p.Lf*sum(hi) + p.co*p.rhoo*sum(hml.*tml);
    E_after = -p.Lf*sum(act_hi) + p.co*p.rhoo*sum(hml.*act_tml);
    verifyEqual(testCase, E_after, E_before, 'AbsTol',1e-12);
end


function setupOnce(~)  % do not change function name
    addpath(['..' filesep '..' filesep 'bin']);
    addpath(['..' filesep '..' filesep 'src1']);
    addpath(['..' filesep '..' filesep 'src2']);
end
