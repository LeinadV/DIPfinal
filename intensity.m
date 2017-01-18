function [ output ] = intensity( input )
    output = zeros(size(input, 1), size(input, 2));
    for i = 1:size(input, 1)
        for j = 1:size(input, 2)
            output(i, j) = sum(input(i, j));
        end
    end
end