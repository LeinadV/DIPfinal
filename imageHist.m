function [ histVector ] = imageHist( input )
    histVector = zeros(1, 256);
    for i = 1:size(input, 1)
        for j = 1:size(input, 2)
            histVector(input(i, j)+1) = histVector(input(i, j)+1)+1;
        end
    end
    %{
    figure
    plot(0:255, histVector)
    xlabel('intensity');
    ylabel('number of pixels');
    %}
    %histogram(input)
end

