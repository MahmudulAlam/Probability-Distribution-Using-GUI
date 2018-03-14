% Md Mahmudul Alam
% github.com/MahmudulAlam
function return_value = trapezoidal2(mat,a1,a2,b1,b2)  
% Function parameter(matrix,xlow,xup,ylow,yup) 
% Integration of Bivariate data 
x = mat(:,1) ;
y = mat(:,2) ;
r = correlation(x,y) ; 
sigmax = variance(x) ;
sigmay = variance(y) ;
mux = mean(x) ;
muy = mean(y) ;
% Function for Bivariate PDF
syms x y ; 
factor = 1/(2*pi.*sigmax.*sigmay.*sqrt(1-r.^2)) ;
f = @(x,y) factor.*exp(-.5.*(1./(1-r.^2)).*(((x-mux)./sigmax).^2+((y-muy)./sigmay).^2-2.*r.*(((x-mux).*(y-muy))./(sigmax.*sigmay)))) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adaptive Trapezoidal Rule 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hx = (a2-a1) ;
hy = (b2-b1) ;
z = .5 * hy * (f(x,b1)+f(x,b2)) ;
z = matlabFunction(z) ;
i0 = .5 * hx * (z(a1)+z(a2)) ;

hx = (a2-a1)/2 ;
hy = (b2-b1)/2 ;
z = .5 * hy * (f(x,b1)+f(x,b1+hy)) + .5* hy *(f(x,b1+hy)+f(x,b2)) ;
z = matlabFunction(z) ;
i1 = .5 * hx * (z(a1)+z(a1+hx)) + .5 * hx * (z(a1+hx)+z(a2)) ; 
tollerance =10e-4 ;
while abs(i1-i0) > tollerance
    hx = hx /2 ;
    hy = hy /2 ;
    temp = b1 : hy : b2 ;
    sum = 0 ;
    for i = 1 : length(temp) - 1
        sum = sum + .5 * hy * (f(x,temp(i))+f(x,temp(i+1))) ;
    end
    z = matlabFunction(sum) ;
    temp = a1 : hx : a2 ;
    sum = 0 ;
    for i = 1 : length(temp) - 1
        sum = sum + .5 * hx * (z(temp(i))+z(temp(i+1))) ;
    end
    i0 = i1 ; 
    i1 = sum ; 
end
return_value = i1 ; 
end
