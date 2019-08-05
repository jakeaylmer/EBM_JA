function f_want = Interpolate(x, f, x_want)
% INTERPOLATE Estimate the value of f(x_want) where f is only known at
% sample points x, but x_want is any value.
% This uses simple linear interpolation.
%
% f_want = INTERPOLATE(x_want, x, f) returns the value of f(x_want)
% linearly interpolated from the known points f at known locations x.
% -------------------------------------------------------------------------
    [~, a] = min(abs(x - x_want)); % index of closest value
    if x(a) <= x_want
        if a < length(x)
            f_want = f(a) + (f(a+1)-f(a))*(x_want-x(a))/(x(a+1)-x(a));
        else % outside upper boundary
            f_want = f(a) + (f(a)-f(a-1))*(x_want-x(a))/(x(a)-x(a-1));
        end
    else
        if a > 1
            f_want = f(a) + (f(a)-f(a-1))*(x_want-x(a))/(x(a)-x(a-1));
        else % outside lower boundary
            f_want = f(a) + (f(a+1)-f(a))*(x_want-x(a))/(x(a+1)-x(a));
        end
    end

end
