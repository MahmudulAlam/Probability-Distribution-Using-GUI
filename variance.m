% Md Mahmudul Alam
% github.com/MahmudulAlam
function return_value = variance(x)
    mean_value = sum(x) / length(x) ;
    return_value = (sum((x-mean_value).^2))/length(x) ;
end