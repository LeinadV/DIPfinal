function [ output ] = light_remove( input, light )
    output = zeros(size(input));
    m = max(light(:));
    for i = 1:size(input, 1)
        for j = 1:size(input, 2)
            if abs(input(i, j)-light(i, j)) > 0.055
                output(i, j) = input(i, j);
            else
                output(i, j) = m;
            end
        end
    end
    output = (1-light + input).^10;
end