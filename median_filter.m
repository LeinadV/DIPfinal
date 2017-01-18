function [ output ] = median_filter( input, sz )
    a = repmat(input(1, :), floor(sz/2), 1);
    input = [a; input; a];
    a = repmat(input(:, 1), 1, floor(sz/2));
    input = [a, input, a];
    output = zeros(size(input));
    for i = ceil(sz/2):size(input, 1)-floor(sz/2)
        for j = ceil(sz/2):size(input, 2)-floor(sz/2)
            output(i, j) = median(median(input(i+1-ceil(sz/2):i+sz-ceil(sz/2), j+1-ceil(sz/2):j+sz-ceil(sz/2))));
        end
    end
    output = output(ceil(sz/2):size(output, 1)-floor(sz/2), ceil(sz/2):size(output, 2)-floor(sz/2));
end