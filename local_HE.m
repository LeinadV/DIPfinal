function [ output ] = local_HE( input )
    output = zeros(size(input));
    input = uint8(input);
    for i = 1:size(input, 1)
        output(i, :) = histEqualization(input(i, :));
    end
    output = single(output/255);
end