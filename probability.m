function return_value = probability(set_of_data,value)
    x = set_of_data ;
    mu = mean(x) ;
    var = variance(x) ;
    sigma = sqrt(var) ;
    factor = 1/(sigma*sqrt(2*pi)) ;
    f = @(x) factor .* exp(-(((x-mu).^2)/(2*sigma.^2))) ;
    return_value = f(value) ;
end