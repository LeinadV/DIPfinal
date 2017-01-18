function [ output ] = line_detect( input, len )
    output = ones(size(input));
    for i = 1:20
        kernal = strel('line', len, i);
        output = output.*imclose(input, kernal);
    end
end

