function return_value = trapezoidal1(x,l_limit,u_limit)
% Integration of Univariate Data 
mu = mean(x) ;
var = variance(x) ;
sigma = sqrt(var) ;
% Function for Univariate PDF
f = @(x) (1/(sigma.*sqrt(2*pi))) .* exp(-.5*(((x-mu)./sigma).^2)) ;
a = l_limit ;
b = u_limit ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adaptive Trapezoidal Rule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = (b-a) ;
i0 = .5 * h * (f(a)+f(b)) ;
h = h/2 ;
i1 = .5*h*(f(a)+f(a+h)) + .5*h*(f(a+h)+f(b)) ;
tollerance = 10e-10 ;
while abs(i1-i0) > tollerance 
    h = h /2 ;
    x = a : h : b ;
    sum = 0 ;
    for i = 1 : length(x) - 1
        sum = sum + .5 * h * (f(x(i))+f(x(i+1))) ;
    end
    i0 = i1 ; 
    i1 = sum ;
end
return_value = sum ;
end
