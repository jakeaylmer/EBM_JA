function tests = test_Interpolate
% TEST_INTERPOLATE Carry out unit tests for the INTERPOLATE function.
    tests = functiontests(localfunctions);
end

%----------------------------------------------------------------------

function test_KnownPoint(testCase)
    xtest = [1.1 2.1 3.1 4.1];
    ftest = [3.5 4.7 7.2 12.1];
    actl = Interpolate(xtest, ftest, 3.1);
    verifyEqual(testCase, actl, 7.2, 'AbsTol',1e-12);
end

function test_UniformProfile(testCase)
    xtest = [-2 -1 0 1 2];
    ftest = [4 4 4 4 4];
    actl = Interpolate(xtest, ftest, 1.1);
    verifyEqual(testCase, actl, 4, 'AbsTol',1e-12);
end

function test_LinearCaseMidPoint(testCase)
    xtest = [1 2 3 4 5];
    ftest = [2 4 6 8 10];
    actl = Interpolate(xtest, ftest, 2.5);
    verifyEqual(testCase, actl, 5, 'AbsTol',1e-12);
end

function test_LinearCaseOffCentre(testCase)
    xtest = [1 2 3 4 5];
    ftest = [3 6 9 12 15];
    actl = Interpolate(xtest, ftest, 10/3);
    verifyEqual(testCase, actl, 10, 'AbsTol',1e-12)
end

function test_DecreasingFunction(testCase)
    xtest = [1 2 3 4 5];
    ftest = [9 6 1 -6 -15];
    actl = Interpolate(xtest, ftest, 2.5);
    verifyEqual(testCase, actl, 3.5, 'AbsTol',1e-12);
end

function test_NonUniformGrid(testCase)
    xtest = [1 2 4 7 11];
    ftest = [5 7 8 9 14];
    actl = Interpolate(xtest, ftest, 5);
    verifyEqual(testCase, actl, 25/3, 'AbsTol',1e-12);
end

function test_ProvideDecreasingGrid(testCase)
    xtest = [5 4 3 2 1];
    ftest = [15 12 9 6 3];
    actl = Interpolate(xtest, ftest, 10/3);
    verifyEqual(testCase, actl, 10, 'AbsTol',1e-12);
end

function test_OutsideDomainLower(testCase)
    xtest = [1 2 3];
    ftest = [2 5 8];
    actl = Interpolate(xtest, ftest, 0.5);
    verifyEqual(testCase, actl, 0.5, 'AbsTol',1e-12);
end

function test_OutsideDomainUpper(testCase)
    xtest = [1 2 3];
    ftest = [2 5 8];
    actl = Interpolate(xtest, ftest, 4);
    verifyEqual(testCase, actl, 11, 'AbsTol',1e-12);
end

function test_OutsideDomainLowerUniform(testCase)
   xtest = [1 2 3 4];
   ftest = [9 9 9 9];
   actl = Interpolate(xtest, ftest, -4);
   verifyEqual(testCase, actl, 9, 'AbsTol',1e-12);
end

function test_OutsideDomainUpperUniform(testCase)
   xtest = [1 2 3 4];
   ftest = [1 3 5 5];
   actl = Interpolate(xtest, ftest, 10);
   verifyEqual(testCase, actl, 5, 'AbsTol',1e-12);
end

function setupOnce(~)  % do not change function name
    addpath(['..' filesep '..' filesep 'bin']);
    addpath(['..' filesep '..' filesep 'src1']);
    addpath(['..' filesep '..' filesep 'src2']);
end
