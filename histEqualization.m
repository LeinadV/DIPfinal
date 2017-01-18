function [ output, T ] = histEqualization( input )
    %{
    for i = 1:size(input, 1)
        for j = 1:size(input, 2)
            if input(i, j)==0
                input(i, j) = 1;
            end
        end
    end
    %}
    hist_r = imageHist(input);
    [m, n] = size(input);
    T(1) = 255*hist_r(1)/m/n;
    for i = 2:256
        T(i) = T(i-1)+255*hist_r(i)/m/n;
    end
    
    T = uint8(T);
    %{
    figure
    stairs(T);
    xlabel('r');
    ylabel('s');
    %}
    output = zeros(m, n);
    for i = 1:m
        for j = 1:n
            output(i, j) = T(input(i, j)+1);
        end
    end
    output = uint8(output);
    imageHist(output);
end

