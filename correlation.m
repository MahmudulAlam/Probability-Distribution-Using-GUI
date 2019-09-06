function return_value = correlation(x,y) 
    n = length(x) ;
    a = n .* sum(x.*y) - sum(x) .* sum(y) ;
    b = n .* sum(x.^2) - (sum(x)).^2 ;
    c = n .* sum(y.^2) - (sum(y)).^2 ;
    return_value = (a./sqrt(b.*c)) ;
end