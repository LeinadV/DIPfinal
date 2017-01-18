function [ output ] = spatialFiltering( input, mask )
    mask = double(mask);
    input = double(input);
    m = size(mask, 1);
    n = size(mask, 2);
    a = repmat(input(1, :), floor(m/2), 1);
    input = [a; input; a];
    a = repmat(input(:, 1), 1, floor(n/2));
    input = [a, input, a];
    output = zeros(size(input));
    for i = ceil(m/2):size(input, 1)-floor(m/2)
        for j = ceil(n/2):size(input, 2)-floor(n/2)
            for k = 1:size(mask, 1)
                for l = 1:size(mask, 2)
                    output(i, j) = output(i, j)+input(i+k-ceil(m/2), j+l-ceil(m/2))*mask(m-k+1, n-l+1);
                end
            end
        end
    end
    output = output(ceil(m/2):size(output, 1)-floor(m/2), ceil(n/2):size(output, 2)-floor(n/2));
end